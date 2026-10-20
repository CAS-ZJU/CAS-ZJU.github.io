# Include site-owned Sass in al-folio's stylesheet fingerprint. The upstream
# cache-bust filter otherwise hashes only the theme's Sass directory.
require "digest"

module ClusterStyleCache
  def bust_css_cache(file_name)
    site = @context.registers[:site]
    roots = [site.source, site.theme&.root].compact
    files = roots.flat_map do |root|
      Dir[File.join(root, "_sass", "**", "*.scss")] +
        Dir[File.join(root, "assets", "css", "*.scss")]
    end.uniq.sort
    digest = Digest::SHA256.new
    files.each { |file| digest.update(File.binread(file)) }
    "#{file_name}?v=#{digest.hexdigest[0, 16]}"
  end
end

Liquid::Template.register_filter(ClusterStyleCache)
