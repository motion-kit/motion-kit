describe MK::Calculator do

  it 'should memoize' do
    c1 = MK::Calculator.scan('0')
    c2 = MK::Calculator.scan('0')
    c1.should == c2
  end

  {
    '100' => [0, 100],
    '+100' => [0, 100],
    '-100' => [0, -100],
    '1.5' => [0, 1.5],
    '-1.5' => [0, -1.5],

    '25%' => [0.25, 0],
    '100%' => [1, 0],

    '25% + 10' => [0.25, 10],
    '100% - 100' => [1, -100],
  }.each do |string, calc|
    it "Should handle #{string.inspect}" do
      factor = calc[0]
      constant = calc[1]
      c = MK::Calculator.scan(string)
      c.factor.should == factor
      c.constant.should == constant
    end
  end

end
