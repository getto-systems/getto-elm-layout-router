module Getto::Elm::Layout::Router
  class Container < BasicObject
    using HashEx

    def initialize(path,app)
      @path = path
      @app = app
      @config = {}
    end

    def namespace(path,config={},&block)
      @config.merge! Container.new(@path.dup.push(path),@app.deep_merge(config)).instance_exec(&block)
    end
    def page(page,title,config={})
      path = @path + [page]
      path_str = path.join("/")
      @config.merge!(
        path_str => @app.deep_merge(config).deep_merge(
          title: title,
          module: path.map{|p|
            "_#{p}".gsub(/_./){|k| k[1].upcase}
          }.join("."),
          path: path_str,
        )
      )
    end
  end
end
