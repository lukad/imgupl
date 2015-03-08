class DummyController < ApplicationController
  def dummy
    render inline: '<h1>dummy</h1>', layout: 'application'
  end
end
