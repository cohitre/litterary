module SidebarHelper
  def sidebar &block
    a = capture_haml do
      haml_tag :div, :id => 'sidebar' do
        haml_tag :div, :class => 'options-wrapper' do
          haml_tag :div, :class => "options" do
            haml_concat capture_haml(&block)
          end
        end
      end
    end
    haml_concat a
  end
end
