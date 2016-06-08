module Admin::DashboardHelper

  ###
  # These methods are used to display information in the datatables in the admin panel
  ###

  # return the attribute encased in a div, and display message in case of null
  def safe_show(attribute, alternate_message="NULL")
    if attribute
      content_tag(:div, attribute)
    else
      content_tag(:div, alternate_message, style: "color: red; font-weight: bold")
    end
  end

  # generate the form containing the select box for dynamically changing the priority
  # in authors and participants
  def priority_show(attribute, form_type, action, token)
    options = ""
    (1..10).each do |num|
      if attribute == num
        options += "<option value='#{num}' selected>#{num}</option> "
      else
        options += "<option value='#{num}'>#{num}</option> "
      end
    end
    form = ("<span class='invisible'>#{attribute}</span> <form data-form_type='#{form_type}' novalidate='novalidate' data-remote='true' method='post' action='#{action}' accept-charset='UTF-8'> <input type='hidden' name='_method' value='patch'> <input type='hidden' name='authenticity_token' value='#{token}'> <select name='priority' onchange='changePriority(this.form);' class='.btn-info'> #{options}</select> </form>").html_safe

    content_tag(:div, form)
  end

  # show the member avater. In case of no avatar display the fontawesome icon user
  def avatar_show(member, image_style="", default_image_style="", div_class="")
    content_tag(:div, member.avatar? ? image_tag(member.avatar.url, style: image_style) : fa_icon("user", style: default_image_style),
                class: div_class )
  end

  # show the website logo. In case of no logo display the fontawesome globe icon
  def logo_show(website, image_style="", default_image_style="", div_class="")
    content_tag(:div, website.logo? ? image_tag(website.logo.url, style: image_style) : fa_icon("globe", style: default_image_style),
                class: div_class )
  end

  # If the author is a member, display a fontawesome users icon. Else an empty string
  def isMember_show(author)
    content_tag(:div, author.isMember? ? ("<i class='fa fa-users' style='font-size: 20px'><p style='display: none'>a</p></i>").html_safe : "", class: "isMember")
  end

  # Methods for showing Invitation Status in datatables
  def invitation_status_to_string(member)
    if member.invitation_pending?
      'Invitation Pending'
    else
      "<span class='glyphicon glyphicon-ok' aria-hidden='true'></span>"
    end
  end

  def invitation_accepted_to_string(member)
    if member.invitation_accepted_at.nil?
      '-'
    else
      "#{member.invitation_accepted_at.to_date} at #{member.invitation_accepted_at.to_s(:time)}"
    end
  end

  def invitation_sent_to_string(member)
    if member.invitation_sent_at.nil?
      '-'
    else
      "#{member.invitation_sent_at.to_date} at #{member.invitation_sent_at.to_s(:time)}"
    end
  end

end
