module Admin
  module SendSms
    class Base
      attr_reader :records, :template_code

      def initialize(records, template_code)
        @records = records
        @template_code = template_code
      end

      def send_sms
      end
    end

    class Ali < Base
      def send_sms
        records.each do |record|
          template_param = to_params(record)
          phone_numbers = record.phone
          Aliyun::Sms.send(phone_numbers, template_code, template_param)
        end
      end

      def to_params(record)
        order_data = ::Admin::OrderData.new(order: record)
        {"conference" => record.conference.name,
          "hotel" => record.hotel.name,
          "period" => "#{order_data.check_in_out}#{order_data.nights}天",
          "names" => order_data.all_names_string,
          "total_people" => order_data.peoples_count,
          "rooms" => order_data.room_type_zh + order_data.room_count_zh,
          "price" => order_data.price,
          "breakfast" => "#{order_data.breakfast_boolean}"
         }.to_json
      end
    end

    class Tencent < Base
      def send_sms(records, template_code)
        records.each do |record|
          template_param = to_params(record)
          phone_number = record.phone
          Qcloud::Sms.single_sender(phone_number, template_code, params)
        end
      end

      def to_params(record)
        order_data = ::Admin::OrderData.new(order: record)
        [
          record.conference.name,
          record.hotel.name,
          "#{order_data.check_in_out}#{order_data.nights}天",
          order_data.all_names_string,
          order_data.peoples_count,
          order_data.room_type_zh + order_data.room_count_zh,
          order_data.price_zh,
          "#{order_data.breakfast}"
        ]
      end

    end

  end
end
