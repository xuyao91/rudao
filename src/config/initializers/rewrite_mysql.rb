# rewrite mysql_adpater.rb
#module ActiveRecord
#  module ConnectionAdapters
#    class MysqlAdapter < AbstractAdapter
#      private
#      def select(sql, name = nil)
#        @connection.query_with_result = true
#          result = execute(sql, name)
#          rows = []
#          result.each_hash { |row| rows << row }
#          result.free
#          #bug description:
#          #error occured if utf-8 concat asscii-8bit string
#          if @config[:encoding] && @config[:encoding]=="utf8"
#            rows.each do |row|
#              row.each do |key, value|
#                if (value.class == String)
#                  value.force_encoding("UTF-8")
#                end
#              end
#            end
#          end
#          #end add
#          @connection.more_results && @connection.next_result    # invoking stored procedures with CLIENT_MULTI_RESULTS requires this to tidy up else connection will be dropped
#          rows
#      end
#    end
#  end
#end