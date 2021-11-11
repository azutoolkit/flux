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

  def initialize(engine = :firefox, options = Marionette.firefox_options(args: [""]))
    @browser = Marionette::WebDriver.create_session(engine, capabilities: options)
  end

  def step(&block)
    with self yield
  ensure
    close
  end

  def fullscreen
    current_window.fullscreen
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

  def fill(el, value, by = :id)
    field(el, by).not_nil!.send_keys(value)
  end

  def text
    element_text(el)
  end

  def submit(el, by = :id)
    if sub_el = find_element el, Marionette::LocationStrategy.parse(by.to_s)
      sub_el.click
    end
  end

  def field(name, by = :id)
    find_element name, Marionette::LocationStrategy.parse(by.to_s)
  end
end
