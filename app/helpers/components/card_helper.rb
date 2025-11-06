module Components::CardHelper
  def render_card(title: nil, subtitle: nil, body: nil, footer: nil, **options, &block)
    card_classes = tw("w-[350px]", options[:class])

    render "components/ui/card", title: title, subtitle: subtitle, footer: footer, body: (block ? capture(&block) : body), card_classes: card_classes, block:, options: options
  end
end
