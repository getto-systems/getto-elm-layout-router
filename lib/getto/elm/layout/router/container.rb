module Getto::Elm::Layout::Router
  class Container < BasicObject
    using HashEx

    def initialize(path,app)
      @path = path
      @app = app
      @config = {}
    end

    def namespace(path,&block)
      @config.merge! Container.new(@path.dup.push(path),@app).instance_exec(&block)
    end
    def page(page,title,config={})
      path = @path + [page]
      @config.merge!(
        path.join("/") => @app.deep_merge(config).deep_merge(
          title: title,
          module: path.map{|p|
            "_#{p}".gsub(/_./){|k| k[1].upcase}
          }.join("."),
        )
      )
    end
  end
end
