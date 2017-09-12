require "json"

module Getto::Elm::Layout::Router
  class Drawer
    def initialize(output_file,app={})
      @output_file = output_file
      @app = app
    end

    def draw(&block)
      File.write @output_file, build(&block)
    end
    def build(&block)
      Container.new([],@app).instance_exec(&block)
    end
  end
end
