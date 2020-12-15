class Application
attr_accessor :items

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/item/)
        resp.write "#{item}\n"
      end

    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |cart_item|
          resp.write "#{cart_item}\n"
        end
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/add/)
      search_term = req.params["item", "price"]
      resp.write add_item(search_term)

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end


  def add_item(search_term)
    if @@items.include?(search_term)
      @@cart << search_term
      return "added #{search_term}"
    else
      return "We don't have that item"
    end
  end

end
