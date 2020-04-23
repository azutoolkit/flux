require "marionette"

class Flux
  forward_missing_to @browser

  @browser : Marionette::Browser

  def initialize
    @browser = Marionette.launch
  end

  def step(&block)
    with self yield
    quit
  end

  def checkbox(id, checked = true)
    execute_script(
      "document.getElementById(arguments[0]).checked = #{checked};",
      [id, checked])
    sleep 70.millisecond
  end

  def session
    create_session
  end

  def visit(path : String)
    goto "#{path}"
  end

  def click(el)
    click_element(el)
  end

  def clear(el)
    clear_element(el)
  end

  def enabled?(el)
    element_enabled?(el)
  end

  def selected?(el)
    element_selected?(el)
  end

  def displayed?(el)
    element_displayed?(el)
  end

  def attr(el, value)
    element_attribute(el, value)
  end

  def css(el, prop)
    element_css_property(el, prop)
  end

  def fill(field el, with value)
    field(el).not_nil!.send_keys(value)
  end

  def text
    element_text(el)
  end

  def submit(el)
    field(el).not_nil!.click
  end

  def field(id, by = Marionette::Browser::LocatorStrategy::Name)
    find_element by, id
  end
end
