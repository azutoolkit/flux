require "marionette"

class Flux
  forward_missing_to @browser

  @browser : Marionette::Session

  def self.step
    flux = new
    with flux yield

    sleep 70.millisecond
    flux.stop
  end

  def initialize
    @browser = Marionette::WebDriver.create_session(:firefox)
  end

  def step(&block)
    with self yield
    stop
    close
  end

  def checkbox(id, checked = true)
    execute_script(
      "document.getElementById(arguments[0]).checked = #{checked};",
      [id, checked])
  end

  def session
    create_session
  end

  def visit(path : String)
    navigate "#{path}"
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
    if sub_el = find_element el
      sub_el.click
    end
  end

  def field(name, by = Marionette::LocationStrategy::Name)
    find_element name, by
  end
end
