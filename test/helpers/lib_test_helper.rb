ENV['APP_ENV'] = 'test'

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest-colorize'
require 'pry'

require 'babel_fish'
require 'babel_fish/translation'

require 'support/config'
require 'support/host_dummy'