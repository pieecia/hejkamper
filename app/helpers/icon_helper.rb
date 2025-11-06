module IconHelper
  def svg_icon(name, options = {})
    file_path = Rails.root.join("app", "assets", "images", "icons", "#{name}.svg")

    return unless File.exist?(file_path)

    svg_content = File.read(file_path)
    css_class = options[:class] || ""

    svg_content.gsub("<svg", "<svg class='#{css_class}'").html_safe
  end
end