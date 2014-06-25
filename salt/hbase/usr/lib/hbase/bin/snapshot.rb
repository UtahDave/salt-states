include Java

import org.apache.hadoop.hbase.client.HBaseAdmin
import org.apache.hadoop.hbase.HBaseConfiguration

admin = HBaseAdmin.new(HBaseConfiguration.create)

admin.listTables.each do |i|
  t = i.getNameAsString
  admin.snapshot(t + '_' + Time.new().to_i.to_s, t)
end
