using Pkg
using JLD2
using CSV
using DataFrames

file_path = "D:/file/读研笔记/笔记/课程/数据中台/jldpath/trips_150104(1).jld2"
data = load(file_path)
df = DataFrame(data["trips"])


# 计算DataFrame的行数
df_length = nrow(df)
println(names(df))
println(df_length)
# 添加id列
df[!, :id] = range(152553, 152553+df_length-1)
# println(first(df, 10))
println(152553+df_length-1)

result_df = DataFrame(id = Int[], route_geom = String[],num = Int[])

# 遍历原始 DataFrame 的每一行
for i in 1:nrow(df)
    # 获取当前行的 id 和 数组
    current_id = df[i, :id]
    route_geom_values = df[i, :route_geom]

    # 遍历 lon_value, lat_value , tms_value 数组中的每个元素
    for (num, (lon_value, lat_value,tms_value)) in enumerate(zip(lon_values, lat_values ,tms_values))
        # 将 id、lon_value, lat_value , tms_value的值和 num 添加到结果 DataFrame 中
        push!(result_df, (current_id,lon_value, lat_value ,tms_value, num))
    end
end

# 查看结果
println(first(result_df,10))

# 指定要保存的 CSV 文件路径
csv_file_path = "D:/file/读研笔记/笔记/课程/数据中台/jldpath/ods_ljl_trips_route_geom_4.csv"

# 将 DataFrame 写入到 CSV 文件中
CSV.write(csv_file_path, result_df)

println("CSV file has been written to: $csv_file_path")

# 读取 CSV 文件
df = CSV.read(csv_file_path, DataFrame)

# 查看行数
row_count = size(df, 1)
println("行数: $row_count")
