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