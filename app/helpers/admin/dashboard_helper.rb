module Admin::DashboardHelper

  ###
  # These methods are used to display information in the datatables in the admin panel
  # They also set the data attritube data-tdclass to the value that the column that
  # they belong to will have as class. After each row is created, each the cells are
  # looped over, and the class of their cell is set to the the vale of their data-tdclass
  # attribute. This assignment is being performed in the dashboard.coffee file.
  ###

  # return the attribute encased in a div, and display message in case of null
  def safe_show(attribute, alternate_message="NULL")
    if attribute
      content_tag(:div, attribute, data: { tdclass: "" })
    else
      content_tag(:div, alternate_message, style: "color: red; font-weight: bold", data: { tdclass: "" })
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

    content_tag(:div, form, data: { tdclass: "" })
  end

  def boolean_show(attribute)
    content_tag(:div, attribute, data: { tdclass: "" })
  end

  # show the member avater. In case of no avatar display the fontawesome icon user
  def avatar_show(member, image_style="", default_image_style="", div_class="")
    content_tag(:div, member.avatar? ? image_tag(member.avatar.url, style: image_style) : fa_icon("user", style: default_image_style),
                class: div_class, data: { tdclass: "avatarColumn" } )
  end

  # show the website logo. In case of no logo display the fontawesome globe icon
  def logo_show(website, image_style="", default_image_style="", div_class="")
    content_tag(:div, website.logo? ? image_tag(website.logo.url, style: image_style) : fa_icon("globe", style: default_image_style),
                class: div_class, data: { tdclass: "buttonColumn" } )
  end

  # If the author is a member, display a fontawesome users icon. Else an empty string
  def isMember_show(author)
    content_tag(:div, author.isMember? ? ("<i class='fa fa-users' style='font-size: 20px'><p style='display: none'>a</p></i>").html_safe : "",
    class: "isMember", data: { tdclass: "isMemberColumn" } )
  end

  # custom link_to tag, for use with column containing buttons in the datatables.
  # Automatically sets the data-tdclass attribute to " buttonColumn"
  def link_to_button_column(name = nil, options = nil, html_options = nil, &block)

    html_options, options, name = options, name, block if block_given?
    options ||= {}

    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(options)
    html_options['href'] ||= url

    html_options["data-tdclass"] = " buttonColumn"

    content_tag(:a, name || url, html_options, &block)
  end

  # Methods for showing Invitation Status in datatables
  def invitation_status_to_string(member)
    if member.invitation_pending?
      content_tag(:div, 'Invitation Pending', data: { tdclass: "" })
    else
      content_tag(:div, ("<span class='glyphicon glyphicon-ok' aria-hidden='true'></span>").html_safe, data: { tdclass: "" })
    end
  end

  def invitation_accepted_to_string(member)
    if member.invitation_accepted_at.nil?
      content_tag(:div ,'-', data: { tdclass: "" })
    else
      content_tag(:div, ("#{member.invitation_accepted_at.to_date} at #{member.invitation_accepted_at.to_s(:time)}").html_safe, data: { tdclass: "" })
    end
  end

  def invitation_sent_to_string(member)
    if member.invitation_sent_at.nil?
      content_tag(:div ,'-', data: { tdclass: "" })
    else
      content_tag(:div, ("#{member.invitation_sent_at.to_date} at #{member.invitation_sent_at.to_s(:time)}").html_safe, data: { tdclass: "" })
    end
  end

end
