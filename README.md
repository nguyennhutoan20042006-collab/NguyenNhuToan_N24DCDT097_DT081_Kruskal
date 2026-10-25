# TIỂU LUẬN KẾT THÚC MÔN HỌC: CẤU TRÚC DỮ LIỆU VÀ GIẢI THUẬT
# ĐỀ TÀI DT081: THUẬT TOÁN KRUSKAL CHỌN CẠNH BẰNG SẮP XẾP VÀ TẬP CHA CON (DSU)

HỌ VÀ TÊN : NGUYỄN NHƯ TOÀN
MÃ SỐ SINH VIÊN : N24DCDT097
LỚP: D24CQDT01-N
GIẢNG VIÊN HƯỚNG DẪN: HỒ NHỰT MINH
NGÔN NGỮ ĐƯỢC SỬ DỤNG: JULIA (v1.12.6)
Kho lưu trữ GitHub: https://github.com/nguyennhutoan20042006-collab/NguyenNhuToan_N24DCDT097_DT081_Kruskal
Commit SHA đối chiếu (SHA C): `c5697f1ee2e628a04e04990ccc22fd6f29dbd842`

---

# 1. GIỚI THIỆU BÀI TOÁN
Bài toán tìm cây bao trùm nhỏ nhất (Minimum Spanning Tree - MST) trên đồ thị vô hướng liên thông có trọng số gồm $n$ đỉnh ($1 \le n \le 30$) và $m$ cạnh ($0 \le w \le 1000$).
Đề tài cài đặt thuật toán Kruskal mộc mạc từ nền tảng:
- Tự định nghĩa cấu trúc dữ liệu cạnh `Canh` và cấu trúc tập cha con `TapChaCon` (DSU).
- Tích hợp kỹ thuật nén đường đi (Path Compression) cho thao tác `tim!` và phát hiện chu trình khi gọi `hop!`.
- Tự cài đặt thuật toán sắp xếp chèn trực tiếp `sap_xep_canh!` (Insertion Sort) đảm bảo tính ổn định.
- Cơ chế dừng sớm tối ưu: vòng lặp tự động ngắt ngay khi đã chọn đủ đúng $n - 1$ cạnh hợp lệ.
- Thẩm định tính liên thông và tính không chu trình độc lập qua hàm `kiem_tra_cay_mst`.

---

# 2. CẤU TRÚC THƯ MỤC DỰ ÁN
```text
Nguyennhutoan_DT081_Kruskal/
├── .gitignore                                      # Bộ lọc loại bỏ file rác, file tạm
├── README.md                                       # Tài liệu hướng dẫn cài đặt và thực thi dự án
├── N24DCDT097_DT081_NguyenNhuToan_ThongTinNop.txt  # Thông tin nộp bài, URL repo và mã băm SHA
├── docs/                                           # Chứa các ảnh minh chứng thực nghiệm A01 - A11
├── scripts/
│   └── demo.jl                                     # Kịch bản chạy mô phỏng lần vết từng bước đồ thị mẫu
├── src/
│   └── Kruskal.jl                                  # Module mã nguồn cốt lõi (DSU, Insertion Sort, Kruskal)
└── test/
    └── runtests.jl                                 # Bộ kiểm thử tự động 34 ca kiểm thử độc lập
```

    ---

# 3. NHẬT KÝ PHÁT TRIỂN VÀ CÁC LỖI KỸ THUẬT ĐÃ VƯỢT QUA

Trong quá trình trực tiếp thiết kế, cài đặt và kiểm thử giải thuật trên ngôn ngữ Julia (v1.12.6), tác giả đã ghi nhận và tự khắc phục các nhóm lỗi thực tế:

# Lỗi cú pháp và hệ thống quy ước của Julia

- Cú pháp chú thích: Ban đầu gõ nhầm comment kiểu C/C++ (`//`) thay vì ký tự `#` của Julia, khiến trình biên dịch hiểu nhầm là phép chia.

- Quy ước kiểu dữ liệu: Nhầm lẫn kiểu `int`, `vector{int}` thay vì chữ hoa đầu `Int`, `Vector{Int}`, gây lỗi `UndefVarError`.

- Quy tắc đặt tên biến: Dùng dấu gạch nối trong tên biến (`so-dinh`, `cap-canh`) làm Julia phân tích cú pháp thành phép trừ toán học; đã khắc phục bằng cách dùng dấu gạch dưới `_`.

- Xung đột kiểu struct trên REPL: Khi sửa đổi `mutable struct TapChaCon` và gọi `include()` nạp lại trong cùng một phiên REPL, struct mới xung đột với struct cũ lưu trong RAM (`MethodError`); 

giải pháp là dùng `exit()` để mở phiên làm việc mới.

# Lỗi môi trường thực thi và công cụ (VS Code / PowerShell)

- Cơ chế thoát chuỗi của PowerShell: Khi chạy lệnh một dòng `julia -e "include(\"...\")"`, PowerShell tự nuốt dấu ngoặc kép làm đường dẫn bị ngắt quãng; khắc phục bằng cách bọc dấu huyền hoặc chạy trực tiếp bằng tệp script.

- Chế độ phím OVR (Overwrite): Vô tình bấm phím `Insert` kích hoạt chế độ ghi đè, làm ký tự gõ mới xóa mất mã nguồn liền kề.

- Bộ gõ tiếng Việt Telex: Unikey tự động can thiệp sửa từ khóa lập trình (ví dụ biến `dsu` thành `dau`, `hop!` thành `Hợp`), làm trình biên dịch báo thiếu định danh.

# Lỗi logic giải thuật và cài đặt thuật toán

- Chỉ số vòng lặp trong Insertion Sort: Gõ nhầm biến chỉ số lùi `i = i = 1` thay vì `j = i - 1` dẫn đến thiếu biến `j`, và nhầm `j = j + 1` làm tăng nguy cơ lặp vô tận.

- Phép so sánh khóa sắp xếp: Nhầm lẫn chỉ số `ds[i].v` với `ds[j].v` khi thực hiện phép so sánh trượt phần tử trong mảng cạnh.

- Kiểu dữ liệu cấu trúc phụ: Trong hàm thẩm định `kiem_tra_cay_mst`, ban đầu gán nhầm `dsu_phu = canh_chon` (danh sách cạnh) thay vì khởi tạo cấu trúc `TapChaCon(n)`, gây lỗi khi gọi hàm hợp nhất.

# Lỗi trong quá trình kiểm thử tự động
- Thừa từ khóa `end`: Sót một từ khóa `end` ở dòng cuối cùng của tệp `runtests.jl` gây lỗi cú pháp toàn bộ tệp test.

- Khoảng trắng trong cú pháp lệnh: Khai báo biến `tong w = 0` (có khoảng trắng) và khoảng cách trong `using . Kruskal` gây lỗi ngắt dòng parser.