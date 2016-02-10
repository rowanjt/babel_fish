class HostDummy
  include BabelFish

  is_translatable :texts, :descriptions

  def initialize(args={})
    @texts = args.fetch(:texts, {})
    @descriptions = args.fetch(:descriptions, {})
  end
end