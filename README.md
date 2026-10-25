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