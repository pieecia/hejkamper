module Components::AccordionHelper
  def accordion_title(&block)
    content_for :title, capture(&block), flush: true
  end

  def accordion_description(&block)
    content_for :description, capture(&block), flush: true
  end

  def render_accordion(title: nil, description: nil, &block)
    if title && !description
      content_for :description, capture(&block), flush: true
    elsif !title && !description
      capture(&block)
    end

    accordion_id = "accordion-#{SecureRandom.hex(4)}"

    render "components/ui/accordion", title: title, accordion_id: accordion_id, description: description
  end
end
