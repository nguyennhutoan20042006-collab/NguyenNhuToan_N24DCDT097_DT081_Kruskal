# BỘ KIỂM THỬ TỰ ĐỘNG CHO ĐỀ TÀI DT081 - THUẬT TOÁN KRUSKAL
# Sinh viên: Nguyễn Như Toàn - MSSV: N24DCDT097


using Test
# Nạp module Kruskal từ thư mục src
include("../src/Kruskal.jl")
using .Kruskal
@testset "1.kiem thu rang buoc dau vao (kiem_tra_dau_vao)" begin
    # Test 1.1: So dinh n nam ngoai doan [1, 30]
    @test_throws ArgumentError kiem_tra_dau_vao(0,[])
    @test_throws ArgumentError kiem_tra_dau_vao(31,[])
    # Test 1.2: Dinh va trong so khong phai so nguyen
    @test_throws ArgumentError kiem_tra_dau_vao(3, [(1, 2, 2.5)])
    @test_throws ArgumentError kiem_tra_dau_vao(3, [(1, "2", 3)])
    # Test 1.3: Nhan dinh vuot qua mien 1..n
    @test_throws ArgumentError kiem_tra_dau_vao(3, [(1, 4, 10)])
    # Test 1.4: Do thi chua canh khuyen (u == v)
    @test_throws ArgumentError kiem_tra_dau_vao(3,[(2, 2, 5)])
    # Test 1.5: Trong so am hoac vuot qua 1000
    @test_throws ArgumentError kiem_tra_dau_vao(3, [1, 2, -1])
    @test_throws ArgumentError kiem_tra_dau_vao(3,[(1, 2, 1005)])
    # Test 1.6: Canh trung lap (ke ca khi dao dinh)
    @test_throws ArgumentError kiem_tra_dau_vao(3, [(1, 2, 4), (1, 2, 5)])
    @test_throws ArgumentError kiem_tra_dau_vao(3,[(1, 2, 4), (2, 1, 4)])
    # Test 1.7: Du lieu hop le phai tra ve danh sach canh chuan hoa (u < v)
    ds = kiem_tra_dau_vao(3, [(2, 1, 10)])
    @test length(ds) == 1
    @test ds[1].u == 1
    @test ds[1].v == 2
    @test ds[1].w == 10

end

@testset "2.kiem thu thao tac DSU va sap xep canh" begin
    # Test 2.1: Khoi tao DSU n dinh
    dsu = TapChaCon(4)
    @test dsu.so_dinh == 4
    @test dsu.cha == [1, 2, 3, 4]
    # Test 2.2: Hop cac tap hop khong tao chu trinh
    @test hop!(dsu, 1, 2) == true
    @test hop!(dsu, 2, 3) == true
    @test tim!(dsu, 1) == tim!(dsu, 3)     # cung goc dai dien
    # Test 2.3: Phat hien chu trinh khi noi 2 dinh da cung thanh phan
    @test hop!(dsu, 1, 3) == false
    # Test 2.4: Sap xep chen danh sach canh (Insertion Sort)
    # Kiem tra tieu chi: w tang dan -> u tang dan -> v tang dan
    ds = [
        Canh(2, 4, 5)
        Canh(1, 3, 2)
        Canh(1, 2, 2)
        Canh(3, 4, 1)
    ]
    sap_xep_canh!(ds)
    @test ds[1] == Canh(3, 4, 1)
    @test ds[2] == Canh(1, 2, 2)
    @test ds[3] == Canh(1, 3, 2)
    @test ds[4] == Canh(2, 4, 5)

end