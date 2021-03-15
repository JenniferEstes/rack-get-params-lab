class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      resp.write handle_search(search_term, resp)
    elsif req.path.match(/cart/)
      cart(resp)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term, resp)
    if @@items.include?(search_term)
      resp.write "added #{search_term}"
      @@cart << search_term
    else
      resp.write "We don't have that item"
    end
  end

  def cart(resp)
    if @@cart.empty?
      resp.write "Your cart is empty"
    else
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end
  end
end
