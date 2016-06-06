module Admin::DashboardHelper
  def safe_show(attribute, alternate_message="NULL")
    if attribute
      content_tag(:div, attribute)
    else
      content_tag(:div, alternate_message, style: "color: red; font-weight: bold")
    end
  end

  def avatar_show(member, image_style="", default_image_style="", div_class="")
    content_tag(:div, member.avatar? ? image_tag(member.avatar.url, style: image_style) : fa_icon("user", style: default_image_style),
                class: div_class )
  end

  def logo_show(website, image_style="", default_image_style="", div_class="")
    content_tag(:div, website.logo? ? image_tag(website.logo.url, style: image_style) : fa_icon("globe", style: default_image_style),
                class: div_class )
  end

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
