shared_context 'time freeze' do
  before do
    Timecop.freeze(Time.local(2023, 1, 1))
  end
  after do
    Timecop.return
  end
end