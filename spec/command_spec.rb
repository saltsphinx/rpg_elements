require_relative '../lib/rpg'

describe RPG do
  describe 'Command module' do
    describe '#command' do
      subject(:cmd) { described_class.new }
      context 'when command line is [take, \'apple\', \'table\']' do
        it 'calls #take with %w[apple table]' do
          allow(cmd).to receive(:parse).and_return([:take, 'apple', 'table'])
          allow(cmd).to receive(:aliases).and_return(:take)
          allow(cmd).to receive(:take)

          expect(cmd).to receive(:take).with(%w[apple table])
          cmd.command
        end
      end

      context 'when command line is [12take, \'apple\', \'table\']' do
        it 'calls #take with %w[apple table]' do
          allow(cmd).to receive(:parse).and_return(%w[12take apple table])
          allow(cmd).to receive(:aliases).and_return(nil)
          allow(cmd).to receive(:puts)

          expect(cmd).to receive(:puts).with('Not a command!')
          cmd.command
        end
      end
    end

    describe '#parse' do
      subject(:parse_input) { described_class.new }

      context 'when string is given' do
        it 'returns parsed string' do
          allow(parse_input).to receive(:gets).and_return('look redapple table')
          result = parse_input.parse
          expect(result).to eq(%w[look redapple table])
        end

        it 'returns parsed string' do
          allow(parse_input).to receive(:gets).and_return('12')
          result = parse_input.parse
          expect(result).to eq(%w[12])
        end

        it 'returns parsed string' do
          allow(parse_input).to receive(:gets).and_return(' strike 12orge')
          result = parse_input.parse
          expect(result).to eq(%w[strike])
        end

        it 'returns parsed string' do
          allow(parse_input).to receive(:gets).and_return('(*apple')
          result = parse_input.parse
          expect(result).to eq(%w[])
        end
      end
    end

    describe '#check_data' do
      subject(:argument_data) { described_class.new }

      context 'when arguments include numbers' do
        it 'returns [8, \'apple\', \'table\']' do
          result = argument_data.check_data %w[8 apple table]
          expect(result).to eq([8, 'apple', 'table'])
        end
      end

      context 'when arguments don\'t numbers' do
        it 'returns [\'apple12\', \'table\']' do
          result = argument_data.check_data %w[apple12 table]
          expect(result).to eq(%w[apple12 table])
        end
      end
    end

    describe '#aliases' do
      subject(:cmd_alias) { described_class.new }

      context 'when string is given' do
        it 'returns command' do
          result = cmd_alias.aliases 'interact'
          expect(result).to eq(:interact)
        end

        it 'returns command' do
          result = cmd_alias.aliases 'i'
          expect(result).to eq(:interact)
        end

        it 'returns command' do
          result = cmd_alias.aliases 't'
          expect(result).to eq(:take)
        end

        it 'returns nil' do
          result = cmd_alias.aliases 'taag'
          expect(result).to be_nil
        end
      end
    end

    describe '#get_instance' do
      subject(:item_instance) { described_class.new }

      context ''
    end
  end
end
