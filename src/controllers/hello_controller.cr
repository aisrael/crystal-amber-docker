class HelloController < ApplicationController
  def index
    @who = params["who"]? || "world"
    render("index.slang")
  end
end
