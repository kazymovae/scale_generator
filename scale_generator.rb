class Scale

  #keys
  FLAT_KEYS = %w(A A# B C C# D D# E F F# G G#)
  SHARP_KEYS = %w(A Bb B C Db D Eb E F Gb G Ab)

  #scale
  SHARP_PITCHES = %w(G D A E B F# e b f# c# g# d#)
  FLAT_PITCHES = %w(F Bb Eb Ab Db Gb d g c f bb eb)

  attr_reader :key, :scale_type, :pattern

  def initialize(key, scale_type, pattern = nil)
    @key = key
    @scale_type = scale_type
    @pattern = pattern
  end

  def name
    "#{@key.capitalize} #{@scale_type}"
  end
  
  def pitch
    output = Array.new

    define_scale_and_keys_to_use
    
    i = 0
    pattern_pos = 0

    pos = @keys.index(@key)

    @pattern.split(",") unless @pattern == nil

    while i < 12
      output.push(@scale[pos])

      if @pattern == nil
        pos == 11 ? pos = 0 : pos += 1
      elsif @pattern[pattern_pos] == 'm'
        pos == 11 ? pos = 1 : pos += 2
      elsif @pattern[pattern_pos] == 'M'
        pos == 11 ? pos = 2 : pos += 3
      elsif @pattern[pattern_pos] == 'A'
        pos == 11 ? pos = 3 : pos += 3
      end

      pattern_pos += 1 unless @pattern == nil
      i += 1
    end

    return output
  end
  
  
  def define_scale_and_keys_to_use
    if SHARP_PITCHES.include?(@key)
      @scale = SHARP_PITCHES
      @keys = SHARP_KEYS
    elsif FLAT_PITCHES.include?(@key)
      @scale = FLAT_PITCHES
      @keys = FLAT_KEYS
    end
  end

end