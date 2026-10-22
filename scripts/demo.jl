# KỊCH BẢN CHẠY THỰC NGHIỆM ĐỒ THỊ MẪU - ĐỀ TÀI DT081
# Sinh viên thực hiện: Nguyễn Như Toàn - MSSV: N24DCDT097

include("../src/Kruskal.jl")
using .Kruskal
function chay_thuc_nghiem()
    println("="^60)
    println("     CHAY MO PHONG MINH HOA THUAT TOAN KRUSKAL (DT081)")
    println("     Ho Va Ten Sinh Vien: Nguyen Nhu Toan - MSSV: N24DCDT097")
    println("="^60)
    # Đồ thị thực nghiệm mẫu gồm 6 đỉnh và 9 cạnh
so_dinh = 6
canh_dau_vao = [
    (1, 2, 4),
    (1, 3, 2),
    (2, 3, 1),
    (2, 4, 5),
    (3, 4, 8),
    (3, 5, 10),
    (4, 5, 2),
    (4, 6, 6),
    (5, 6, 3)

]
    println("\n[BUOC 1] KIEM TRA DAU VAO VA CHUAN HOA DU LIEU:")
    ds_canh = kiem_tra_dau_vao(so_dinh, canh_dau_vao)
    println("  -> So dinh: ", so_dinh)
    println("  -> So canh hop le doc duoc: ", length(ds_canh))
    println("\n[BUOC 2] SAP XEP CAC CANH TANG DAN THEO TUNG TRONG SO (Insertion Sort):")
    sap_xep_canh!(ds_canh)
    for c in ds_canh
        println("     Canh (", c.u, ", ", c.v, ") co trong so w = ", c.w)
    end
        println("\n[BUOC 3] QUA TRINH DUYET THAM LAM VA HOP TAP HOP (DSU):")
        println("-"^60)
        println(" Buoc | Xet canh (u, v) [w] |    ket qua DSU   | Hanh dong")
        println("-"^60)
        dsu = TapChaCon(so_dinh)
        canh_cay = Canh[]
        tong_w = 0
        buoc = 0
        for c in ds_canh
            buoc = buoc + 1
            da_hop = hop!(dsu, c.u, c.v)
            if da_hop
                push!(canh_cay, c)
                tong_w = tong_w + c.w 
                trang_thai = "Khac goc   -> NHAN CANH"
            else
                trang_thai = "Cung goc   -> LOAI (tao chu trinh)"
            end 
            println("  ",buoc, "   |  (", c.u, ". ", c.v, ") w = " , c.w, "   | ", trang_thai)
        # Cây bao trùm n đỉnh dừng khi đủ n - 1 cạnh
        if length(canh_cay) == so_dinh - 1
            println("-"^60)
            println("  -> Da gom du ", so_dinh - 1, " canh. Dung thuat toan som!")
            break
        end 
    end
    println("\n[BUOC 4] KET QUA CAY BAO TRUM NHO NHAT (MSI):")
    println("  - Tong trong so nho nhat: ", tong_w)
    println("  - Tap cac canh duoc chon vao cay MSI:")
    for c in canh_cay
        println("   + Canh (", c.u, ", ", c.v, ") voi trong so = ", c.w) 
        
    end
    hop_le = kiem_tra_cay_mst(so_dinh, canh_cay)
    println("  - Trang thai cay bao trum: ", hop_le ? " HOP LE (Lien thong, khong chu trinh)" : "KHONG HOP LE")
    println("-"^60)
end
     # THỰC THI CHƯƠNG TRÌNH
     chay_thuc_nghiem()