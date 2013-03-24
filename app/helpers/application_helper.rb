module ApplicationHelper

  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

  def numeric?
    Float(self) != nil rescue false
  end

  def call_alert
    return "alert 'this should appear'"
  end
  def display_flash!
    flash_alerts = []
    error_key = 'there_were_errors'

    if !flash.empty?
      if flash[:error]
        flash_alerts = make_flash_array(flash_alerts,flash[:error])
        error_type = "error"
      elsif flash[:alert]
        flash_alerts = make_flash_array(flash_alerts,flash[:alert])
        error_type = "error"
      elsif flash[:notice]
        flash_alerts = make_flash_array(flash_alerts,flash[:notice])
        error_type = "success"
      end
    end

    return "" if flash_alerts.empty?
    if flash_alerts.count>1
      messages = flash_alerts.map { |msg| content_tag(:li, msg) }.join
      sentence = content_tag(:h2, I18n.t(error_key, :count => flash_alerts.count),:class=>"alert-heading")
      messages = content_tag(:ul, messages.html_safe)
    else
      messages = ""
      sentence = content_tag(:h2, flash_alerts.to_sentence,:class=>"alert-heading")
    end

    flash[:error] = flash[:notice] = flash[:alert] = nil

    case error_type
      when "success" then
        content_tag :div, content_tag(:button,"x", :class=>"close", "data-dismiss"=>"alert")+sentence+messages.html_safe, :class => "alert alert-success"
      when "error" then
        content_tag :div, sentence+messages.html_safe, :class => "alert alert-error"
      else
        content_tag :div, content_tag(:button,"x", :class=>"close", "data-dismiss"=>"alert")+sentence+messages.html_safe, :class => "alert alert-info"
    end

  end



  def yield_or(name, content = nil, &block)
    if content_for?(name)
      content_for(name)
    else
      block_given? ? capture(&block) : content
    end
  end

  def show_actions(actions)
    if !actions.empty?
      actions.map do |action|
        content_tag( :li, content_tag(:a,action[:msg],:href=> "#", :id=>action[:id]))
      end.join("\n").html_safe
    else
      content_tag :li, t(:there_is_no_action)
    end
  end

  def wrap_long_string(txt,col = 20)
    txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/,
             "\\1\\3\n")
  end
  def loading_tag id
    image_tag("ajax-loader.gif", :id => id, :alt => "Registering, please wait...", :style => "display:none")
  end

  private

  def make_flash_array(flash_alerts, elem)
    if elem.is_a?(Array)
      flash_alerts = flash_alerts + elem
    else
      flash_alerts.push(elem)
    end
    flash_alerts
  end

end
