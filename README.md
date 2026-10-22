# TIỂU LUẬN KẾT THÚC MÔN HỌC: CẤU TRÚC DỮ LIỆU VÀ GIẢI THUẬT
# ĐỀ TÀI DT081: THUẬT TOÁN KRUSKAL CHỌN CẠNH BẰNG SẮP XẾP VÀ TẬP CHA CON (DSU)

HỌ VÀ TÊN : NGUYỄN NHƯ TOÀN
MÃ SỐ SINH VIÊN : N24DCDT097
LỚP: D24CQDT01-N
GIẢNG VIÊN HƯỚNG DẪN: HỒ NHỰT MINH
NGÔN NGỮ ĐƯỢC SỬ DỤNG: JULIA (v1.12.6)


# 1. CẤU TRÚC THƯ MỤC DỰ ÁN
- ' src/Kruskal.jl': Định nghĩa cấu trúc dữ liệu ('Canh', 'TapChaCon'), bộ lọc đầu vào, thuật toán sắp xếp chèn, các thao tác DSU nén đường đi, bộ thẩm định cây và thuật toán Kruskal chính.
- 'test/runtest.jl': Bộ kiểm thử tự động với 34 test cases bao phủ toàn bộ ràng buộc đề bài.
- 'scripts/demo.jl': Kịch bản chạy thực nghiệm lần vết từng bước duyệt cạnh của đồ thị mẫu.
# 2. HƯỚNG DẪN CÀI ĐẶT VÀ CHẠY CHƯƠNG TRÌNH
#### chạy kiểm thử tự động:
'''powershell
julia test/runtest.jl