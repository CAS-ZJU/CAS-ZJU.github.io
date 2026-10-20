require "cgi"

module ClusterPublicationFilters
  VENUE_LABELS = {
    "Social Studies of Science" => "SSS",
    "Big Data & Society" => "BD&S",
    "New Media & Society" => "NM&S",
    "Sociological Methodology" => "SM",
    "Chinese Sociological Review" => "CSR",
    "Journal of the Association for Information Science and Technology" => "JASIST"
  }.freeze

  def publication_badge(work)
    return "arXiv" if work["type"] == "Preprint"
    return "Book" if work["type"] == "Book"

    VENUE_LABELS.fetch(work["venue"], work["venue"])
  end

  def publication_authors(work)
    site = @context.registers[:site]
    people = site.collections.fetch("people").docs.select { |person| Array(work["members"]).include?(person.data["person_id"]) }
    links = {}
    people.each do |person|
      names = [person.data["title"], person.data["chinese_name"]]
      names << "吳桐雨" if person.data["person_id"] == "tongyu-wu"
      names.compact.each do |name|
        links[CGI.escapeHTML(name)] = CGI.escapeHTML("#{site.baseurl}#{person.url}")
      end
    end
    authors = CGI.escapeHTML(work["authors"].to_s)
    return authors if links.empty?

    authors.gsub(Regexp.union(links.keys.sort_by { |name| -name.length })) do |name|
      %(<a href="#{links.fetch(name)}">#{name}</a>)
    end
  end

  def publication_search_text(work)
    site = @context.registers[:site]
    names = site.collections.fetch("people").docs.select do |person|
      Array(work["members"]).include?(person.data["person_id"])
    end.flat_map { |person| [person.data["title"], person.data["chinese_name"]] }
    (%w[title authors venue year type relevance details].map { |key| work[key] } + names).compact.join(" ")
  end

  # Export only metadata already recorded in works.yml. Combined issue/page
  # details remain a note rather than being guessed into separate BibTeX fields.
  def publication_bibtex(work)
    authors = work["authors"].to_s.split(/、|,\s*(?:and\s+)?|\s+and\s+/).reject(&:empty?)
    authors = authors.map do |name|
      parts = name.strip.split
      parts.length > 1 ? "#{parts.pop}, #{parts.join(' ')}" : name.strip
    end.join(" and ")
    type = case work["type"]
           when "Book" then "book"
           when "Preprint" then "misc"
           else "article"
           end
    fields = { "title" => "{#{work['title']}}", "author" => authors, "year" => work["year"] }
    venue_key = { "book" => "publisher", "misc" => "howpublished", "article" => "journal" }.fetch(type)
    fields[venue_key] = work["venue"]
    fields["note"] = work["details"] if work["details"]
    fields["url"] = work["url"]
    fields["doi"] = work["url"].delete_prefix("https://doi.org/") if work["url"].start_with?("https://doi.org/")
    if work["url"].start_with?("https://arxiv.org/abs/")
      fields["archivePrefix"] = "arXiv"
      fields["eprint"] = work["url"].delete_prefix("https://arxiv.org/abs/")
    end
    lines = fields.map do |key, value|
      value = value.to_s.gsub(/[&%$#_]/) { |char| "\\#{char}" } unless %w[url doi eprint].include?(key)
      "  #{key} = {#{value}},"
    end
    "@#{type}{#{work['id']},\n#{lines.join("\n")}\n}"
  end
end

Liquid::Template.register_filter(ClusterPublicationFilters)
