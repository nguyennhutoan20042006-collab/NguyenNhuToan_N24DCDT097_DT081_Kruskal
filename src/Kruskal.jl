module Kruskal
export Canh, TapChaCon, kiem_tra_dau_vao
# Khối 1: Định Nghĩa các cấu trúc dữ liệu cơ bản 
# cấu trúc lưu thông tincuar 1 cạnh trong đồ thị vô hướng.
# Dùng "struct" bất biến ( immutable) vì sau khi đọc cạnh thì 9u,vư) không thay đổi
struct Canh
    u::Int     # định đầu quy ước luôn chuẩn hóa: u < v)
    v::Int     # Định cuối
    w::Int     # trọng số nguyên không âm ( 0<= w <=1000)
end
# cấu trúc tập cha con ( disjoint set union - DSU)
# dùng "mutable struct" vì mảng cha sẽ liên tục bị cập nhật trong quấ trình hợp tập hợp
mutable struct TapChaCon
    cha::Vector{Int}    # mảng cha: cha[i] lư chỉ số đỉnh cha trực tiếp của đỉnh i
    so_dinh::Int     # kích thước số đỉnh của đồ thị
# hàm khởi tạo cấu trúc: ban đàu mỗi đỉnh i là 1 tập hợp độc lập , tự trỏ vào chính nó.
function TapChaCon(n::Int)
    bang_cha = zeros(Int, n)
    for i in 1:n
        bang_cha[i] = i     # khởi tạo ; cha[i] = i theo như trong giáo trình ở phần 6.5.2
end
return new(bang_cha, n)
end
end
# KHỐI 2; HÀM KIỂM TRA ĐẦU VÀO VÀ CHUẨN HÓA DỮ DIỆU 
"""
    kiem_tra-dau-vao(n::Integer, canh_raw)
kiểm tra hợp đồng đầu vào theo quy định của đề tài DT081:
1. số đỉnh n phải là số nguyên thuộc đoạn [1,30] .kruskal
2. trọng số w phải là bộ ba số nguyên thuộc đoạn [0, 1000].
3. Mỗi cạnh là bộ ba số nguyên (u, v, w) với u, v thuộc 1..n.
4. Đồ thị đơn: không có cạnh khuyên (u == v), không có cạnh trùng lặp vô hướng.
Trả về danh sách cạnh đã chuẩn hóa dạng Vector{Canh} với u < v.
"""
function kiem_tra_dau_vao(n::Integer, canh_raw)
    # ràng buộc 1: giới hạn số đỉnh của bài toán
    if n < 1 || n > 30
        throw(ArgumentError("so dinh n phai nam trong doan 1..30"))
    end
    ds_canh = Canh[]
    tap_canh_da_co = Set{Tuple{Int, Int}}()
    # duyệt qua từng cạnh thô để kiểm tra
    for item in canh_raw
        if length(item) != 3
            throw(ArgumentError(" moi canh can dung 3 gia tri (u, v, w)"))
        end
        u_raw, v_raw, w_raw = item
        # Ràng buộc 2: kiểm tra kiểu dữ liệu nguyên
        if !(u_raw isa Integer && v_raw isa Integer && w_raw isa Integer)
            throw(ArgumentError(" dinh va trong so phai la so nguyen"))
        end
        u = Int(u_raw)
        v = Int(v_raw)
        w = Int(w_raw) 
    # ràng buộc 3: kiểm tra miền nhãn đỉnh
    if u < 1 || u > n || v < 1 || v > n
        throw(ArgumentError(" nhan dinh phai nam trong doan 1..n"))
    end
    # Ràng buộc 4: đồ thị đơn không có cạnh khuyên
    if u == v
        throw(ArgumentError("do thi don khong duoc chua canh khuyen (u == v)"))
    end
    # Ràng buộc 5: kiểm tra miền trọng số không ấm
    if w < 0 || w > 1000
        throw(ArgumentError(" trong so w phai nam trong doan 0..1000"))
    end
    # chuẩn hóa cạnh voo hướng : đưa về cặp ( min, max) để u luôn , v
    u_chuan, v_chuan = minmax(u,v)
    cap_canh = (u_chuan, v_chuan)
    # ràng buộc 6 : không trùng lặp cạnh (kể cả khi nhập đảo đỉnh(u,v) và (v,u))
    if cap_canh in tap_canh_da_co
        throw(ArgumentError("Canh bi lap"))
    end
    push!(tap_canh_da_co, cap_canh)
    push!(ds_canh, Canh(u_chuan, v_chuan, w))
end
return ds_canh
end

end # module kruskal
