module UserHelper
  def user_message(condition, &block)
    message = capture_haml do
      haml_tag :div, :id => 'user-message', &block
    end
    content_for(:user_information, message ) if condition
  end

  def user_image user
    image_tag user.avatar.url(:small)
  end

  def user_item user
    capture_haml do
      haml_concat image_tag(user.avatar.url(:small))
      haml_tag :h3, link_to(user.login, user_path(user.login))
      haml_tag :div, safe_simple_format(user.description)
    end
  end

  def users_list users, owner=false
    capture_haml do
      items_list_or_message(users, 'There are no users to display') do |i|
        haml_tag(:li, user_item(i), :class => 'user')
      end
    end
  end

end
