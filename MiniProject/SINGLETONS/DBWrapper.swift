//
//  DBWrapper.swift
//  MiniProj
//
//  Created by Mac Mini-06 on 3/28/18.
//  Copyright © 2018 Mac Mini-06. All rights reserved.
//

import UIKit
import SQLite3


class DBWrapper{
    static let sharedInstance = DBWrapper()
    var db: OpaquePointer?
    
    init() {
        //SQLITE STUFF
        
        let fileURL = try!
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("MiniProject.db")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("ERROR: Error opening MiniProject.db in \(fileURL.path)")
            
        } else {
            print("SUCCESS: Successfully open MiniProject.db in \(fileURL.path)")
        }
    }
    
    func createTables(){
        // EMPLOYEE
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Employee (idEmployee INTEGER PRIMARY KEY  AUTOINCREMENT, NamaEmployee TEXT, AlamatEmployee TEXT, JenisKelamin TEXT, UsernameEmployee TEXT, PasswordEmployee TEXT, LevelEmployee TEXT, idKantor INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: Error creating table Employee: \(errmsg)")
        }
        // KANTOR
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Kantor (idKantor INTEGER PRIMARY KEY AUTOINCREMENT, NamaKantor TEXT, TingkatanKantor TEXT, AlamatKantor TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: Error creating table Kantor: \(errmsg)")
        }
        // BARANG
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Item (idItem INTEGER PRIMARY KEY  AUTOINCREMENT, Deskripsi TEXT, BeratBarang TEXT, StatusPecah TEXT, StatusGaransi TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: Error creating table Item: \(errmsg)")
        }
        // PEMBAYARAN
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Pembayaran (idPembayaran INTEGER PRIMARY KEY  AUTOINCREMENT, idOrder TEXT, NamaPelanggan TEXT, NamaJenisPengiriman TEXT, Deskripsi TEXT, BeratBarang TEXT, StatusPecah TEXT, StatusGaransi TEXT, TarifJenisPengiriman TEXT, TotalPembayaran TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: Error creating table Pembayaran: \(errmsg)")
        }
        // PELANGGAN
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Pelanggan (idPelanggan INTEGER PRIMARY KEY AUTOINCREMENT, NamaPelanggan TEXT, AlamatPelanggan TEXT, KontakPelanggan TEXT, KodePos TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: Error creating table Users: \(errmsg)")
        }
        // JENIS PENGIRIMAN
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS JenisPengiriman (idJenisPengiriman INTEGER PRIMARY KEY AUTOINCREMENT, NamaJenisPengiriman TEXT, DeskripsiJenisPengiriman TEXT, Tarif TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: Error creating table Users: \(errmsg)")
        }
        // KOTA
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Kota (idKota INTEGER PRIMARY KEY AUTOINCREMENT, NamaKota TEXT, RegionKota TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: Error creating table Kota: \(errmsg)")
        }
        // PEMESANAN
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Pemesanan (idOrder INTEGER PRIMARY KEY  AUTOINCREMENT, TanggalPemesanan TEXT, NamaPelanggan TEXT, KotaPengirim TEXT, NamaPenerima TEXT, KotaPenerima TEXT, DeskripsiBarang TEXT, AlamatPenerima TEXT, JenisPengiriman TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: Error creating table Pemesanan: \(errmsg)")
        }
        // PENGIRIMAN
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Pengiriman (idPengiriman INTEGER PRIMARY KEY  AUTOINCREMENT, OrderID TEXT, TanggalPengiriman TEXT, TanggalPenerimaan TEXT, JenisPengiriman TEXT, NamaKurir TEXT, NamaKantor TEXT, StatusPengiriman TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: Error creating table Pemesanan: \(errmsg)")
        }
    }
    // REGISTER EMPLOYEE
    func doRegister(nama: String, alamat: String, jeniskelamin: String, username: String, password: String, level: String, kantor: String) -> Bool {
        var stmt: OpaquePointer?
        let queryString = "INSERT INTO Employee (NamaEmployee, AlamatEmployee, JenisKelamin, UsernameEmployee, PasswordEmployee, LevelEmployee, idKantor) VALUES ('\(nama)','\(alamat)','\(jeniskelamin)','\(username)','\(password)','\(level)','\(kantor)')"
        print ("QUERY REGISTER: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing insert: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    // LOGIN EMPLOYEE
    func doLogin (username: String, password: String) -> [String: String]? {
        let queryString = "SELECT * FROM Employee WHERE UsernameEmployee='\(username)' AND PasswordEmployee='\(password)'"
        print("QUERY LOGIN:  \(queryString)")
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: ReadValues: Error preparing login: \(errmsg)")
            return nil
        }
        var user: [String: String]?
        if sqlite3_step(stmt) == SQLITE_ROW {
            let idAdmin = sqlite3_column_int(stmt, 0)
            let username = String(cString: sqlite3_column_text(stmt, 1))
            let password = String(cString: sqlite3_column_text(stmt, 2))
            user = [String: String]()
            user?["idAdmin"] = String(idAdmin)
            user?["username"] = String(username)
            user?["password"] = String(password)
        }
        return user
    }
    // MENAMPILKAN EMPLOYEE
    func fetchEmployee() -> [[String: String]]? {
        let queryString = "SELECT * FROM Employee"
        print ("QUERY FETCH Employee: \(queryString)")
        var stmt: OpaquePointer?
        var employee: [[String: String]]?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: ReadValues: Error mempersiapkan employee: \(errmsg)")
            return nil
        }
        
        employee = [[String: String]]()
        while (sqlite3_step(stmt)) == SQLITE_ROW {
            let idEmployee = sqlite3_column_int(stmt, 0)
            let NamaEmployee = String(cString: sqlite3_column_text(stmt, 1))
            let AlamatEmployee = String(cString: sqlite3_column_text(stmt, 2))
            let JenisKelamin = String(cString: sqlite3_column_text(stmt, 3))
            let UsernameEmployee = String(cString: sqlite3_column_text(stmt, 4))
            let PasswordEmployee = String(cString: sqlite3_column_text(stmt, 5))
            let LevelEmployee = String(cString: sqlite3_column_text(stmt, 6))
            let idKantor = String(cString: sqlite3_column_text(stmt, 7))
            
            let tmp = [
                "idEmployee": String(idEmployee),
                "NamaEmployee": NamaEmployee,
                "AlamatEmployee": AlamatEmployee,
                "JenisKelamin": JenisKelamin,
                "UsernameEmployee": UsernameEmployee,
                "PasswordEmployee": PasswordEmployee,
                "LevelEmployee": LevelEmployee,
                "idKantor": idKantor
            ]
            employee?.append(tmp)
        }
        
        return employee
    }
    // INSERT EMPLOYEE
    func doInsertEmployee(dataEmployee: [String: String]) -> Bool {
        var stmt: OpaquePointer?
        let idEmployee = dataEmployee["idEmployee"]!
        let NamaEmployee = dataEmployee["NamaEmployee"]!
        let AlamatEmployee = dataEmployee["AlamatEmployee"]!
        let JenisKelamin =  dataEmployee["JenisKelamin"]!
        let UsernameEmployee = dataEmployee["UsernameEmployee"]!
        let PasswordEmployee = dataEmployee["PasswordEmployee"]!
        let LevelEmployee = dataEmployee["LevelEmployee"]!
        let idKantor = dataEmployee["idKantor"]!
        
        let queryString = "INSERT INTO Employee (idEmployee, NamaEmployee, AlamatEmployee, JenisKelamin, UsernameEmployee, PasswordEmployee, LevelEmployee, idKantor) VALUES ('\(idEmployee)','\(NamaEmployee)','\(AlamatEmployee)','\(JenisKelamin)','\(UsernameEmployee)','\(PasswordEmployee)','\(LevelEmployee)','\(idKantor)')"
        print("QUERY UPDATE EMPLOYEE : \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error saat melakukan update: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    // UPDATE EMPLOYEE
    func doUpdateEmployee(dataEmployee: [String: String]) -> Bool {
        var stmt: OpaquePointer?
        let idEmployee = dataEmployee["idEmployee"]!
        let NamaEmployee = dataEmployee["NamaEmployee"]!
        let AlamatEmployee = dataEmployee["AlamatEmployee"]!
        let JenisKelamin =  dataEmployee["JenisKelamin"]!
        let UsernameEmployee = dataEmployee["UsernameEmployee"]!
        let PasswordEmployee = dataEmployee["PasswordEmployee"]!
        let LevelEmployee = dataEmployee["LevelEmployee"]!
        let idKantor = dataEmployee["idKantor"]!
        
        let queryString = "Update Employee SET NamaEmployee='\(NamaEmployee)', AlamatEmployee = '\(AlamatEmployee)', JenisKelamin ='\(JenisKelamin)', UsernameEmployee ='\(UsernameEmployee)', PasswordEmployee ='\(PasswordEmployee)', LevelEmployee ='\(LevelEmployee)', idKantor ='\(idKantor)' WHERE idEmployee = '\(idEmployee)'"
        print("QUERY UPDATE EMPLOYEE : \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error saat melakukan update: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    // DELETE EMPLOYEE
    func doDeleteEmployee(dataEmployee: [String: String]) -> Bool {
        var stmt: OpaquePointer?
        let idEmployee = dataEmployee["idEmployee"]!
        
        let queryString = "DELETE FROM Employee WHERE idEmployee='\(idEmployee)'"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error saat melakukan delete: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    
    
    
    // PELANGGAN
    func fetchPelanggan() -> [[String: String]]? {
        let queryString = "SELECT * FROM Pelanggan"
        print ("QUERY FETCH Pelanggan: \(queryString)")
        var stmt: OpaquePointer?
        var pelanggan: [[String: String]]?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: ReadValues: Error mempersiapkan pelanggan: \(errmsg)")
            return nil
        }
        
        pelanggan = [[String: String]]()
        while (sqlite3_step(stmt)) == SQLITE_ROW {
            let idPelanggan = sqlite3_column_int(stmt, 0)
            let NamaPelanggan = String(cString: sqlite3_column_text(stmt, 1))
            let AlamatPelanggan = String(cString: sqlite3_column_text(stmt, 2))
            let KontakPelanggan = String(cString: sqlite3_column_text(stmt, 3))
            let KodePos = String(cString: sqlite3_column_text(stmt, 4))
            
            let tmp = [
                "idPelanggan": String(idPelanggan),
                "NamaPelanggan": String(NamaPelanggan),
                "AlamatPelanggan": String(AlamatPelanggan),
                "KontakPelanggan": String(KontakPelanggan),
                "KodePos": String(KodePos)
            ]
            pelanggan?.append(tmp)
        }
        
        return pelanggan
    }
    func doInsertPelanggan(dataPelanggan: [String: String]) -> Bool {
        var stmt: OpaquePointer?
        
        let NamaPelanggan = dataPelanggan["NamaPelanggan"]!
        let AlamatPelanggan = dataPelanggan["AlamatPelanggan"]!
        let KontakPelanggan =  dataPelanggan["KontakPelanggan"]!
        let KodePos = dataPelanggan["KodePos"]!
        
        let queryString = "INSERT INTO Pelanggan (NamaPelanggan, AlamatPelanggan, KontakPelanggan, KodePos) VALUES ('\(NamaPelanggan)','\(AlamatPelanggan)','\(KontakPelanggan)','\(KodePos)')"
        print("QUERY INSERT Pelanggan: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error saat melakukan insert: \(errmsg)")
            return false
        }
        
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    func doUpdatePelanggan(dataPelanggan: [String: String]) -> Bool {
        var stmt: OpaquePointer?
        let idPelanggan = dataPelanggan["idPelanggan"]!
        let NamaPelanggan = dataPelanggan["NamaPelanggan"]!
        let AlamatPelanggan = dataPelanggan["AlamatPelanggan"]!
        let KontakPelanggan =  dataPelanggan["KontakPelanggan"]!
        let KodePos = dataPelanggan["KodePos"]!
        
        let queryString = "UPDATE Pelanggan SET NamaPelanggan='\(NamaPelanggan)', AlamatPelanggan = '\(AlamatPelanggan)', KontakPelanggan ='\(KontakPelanggan)', KodePos ='\(KodePos)' WHERE idPelanggan = '\(idPelanggan)'"
        print("QUERY UPDATE Pelanggan : \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error saat melakukan update: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    func doDeletePelanggan(dataPelanggan: [String: String]) -> Bool {
        var stmt: OpaquePointer?
        let idPelanggan = dataPelanggan["idPelanggan"]!
        
        let queryString = "DELETE FROM Pelanggan WHERE idPelanggan='\(idPelanggan)'"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error saat melakukan delete: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    
    
    // KANTOR
    func fetchkantor() -> [[String: String]]? {
        let queryString = "SELECT * FROM Kantor"
        print ("QUERY FETCH kantor: \(queryString)")
        var stmt: OpaquePointer?
        
        var kantor : [[String: String]]?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: ReadValues: Error preparing fetch kantor: \(errmsg)")
            return nil
        }
        kantor = [[String: String]]()
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let idkantor = sqlite3_column_int(stmt, 0)
            let NamaKantor = String(cString: sqlite3_column_text(stmt, 1))
            let TingkatanKantor = String(cString: sqlite3_column_text(stmt, 2))
            let AlamatKantor = String(cString: sqlite3_column_text(stmt, 3))
            
            let tmp = [
                "idKantor" : String(idkantor),
                "NamaKantor" : String(NamaKantor),
                "TingkatanKantor" : String(TingkatanKantor),
                "AlamatKantor" : String(AlamatKantor)
            ]
            kantor?.append(tmp)
        }
        return kantor
    }
    func doUpdatekantor(kantorData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let idKantor = kantorData["idKantor"]!
        let NamaKantor = kantorData["NamaKantor"]!
        let TingkatanKantor = kantorData["TingkatanKantor"]!
        let AlamatKantor = kantorData["AlamatKantor"]!
        
        let queryString = "UPDATE Kantor SET NamaKantor='\(NamaKantor)', TingkatanKantor='\(TingkatanKantor)', AlamatKantor='\(AlamatKantor)' WHERE idKantor='\(idKantor)'"
        print("QUERY UPDATE kantor: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing update: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    func doInsertkantor(kantorData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let NamaKantor = kantorData["NamaKantor"]!
        let TingkatanKantor = kantorData["TingkatanKantor"]!
        let AlamatKantor = kantorData["AlamatKantor"]!
        
        let queryString = "INSERT INTO Kantor (NamaKantor, TingkatanKantor, AlamatKantor) VALUES ('\(NamaKantor)','\(TingkatanKantor)','\(AlamatKantor)')"
        print ("QUERY INSERT kantor: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing insert kantor: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    func dodeletekantor(kantorData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let idKantor = kantorData["idKantor"]!
        
        let queryString = "DELETE FROM Kantor WHERE idKantor='\(idKantor)'"
        print ("QUERY DELETE KANTOR: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing insert kantor: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    
    
    // BARANG
    func fetchitem() -> [[String: String]]? {
        let queryString = "SELECT * FROM Item"
        print ("QUERY FETCH kantorS: \(queryString)")
        var stmt: OpaquePointer?
        
        var Item : [[String: String]]?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: ReadValues: Error preparing fetch Item: \(errmsg)")
            return nil
        }
        Item = [[String: String]]()
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let idItem = sqlite3_column_int(stmt, 0)
            let Deskripsi = String(cString: sqlite3_column_text(stmt, 1))
            let BeratBarang = String(cString: sqlite3_column_text(stmt, 2))
            let StatusPecah = String(cString: sqlite3_column_text(stmt, 3))
            let StatusGaransi = String(cString: sqlite3_column_text(stmt, 4))
            
            let idx = [
                "idItem" : String(idItem),
                "Deskripsi" : Deskripsi,
                "BeratBarang" : BeratBarang,
                "StatusPecah" : StatusPecah,
                "StatusGaransi" : StatusGaransi
            ]
            Item?.append(idx)
        }
        return Item
    }
    func doInsertItem(itemData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let Deskripsi = itemData["Deskripsi"]!
        let BeratBarang = itemData["BeratBarang"]!
        let StatusPecah = itemData["StatusPecah"]!
        let StatusGaransi = itemData["StatusGaransi"]!
        
        let queryString = "INSERT INTO Item (Deskripsi, BeratBarang, StatusPecah, StatusGaransi) VALUES ('\(Deskripsi)','\(BeratBarang)','\(StatusPecah)','\(StatusGaransi)')"
        print ("QUERY INSERT Pembayaran: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing insert Pembayaran: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    func doUpdateItem(itemData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let idItem = itemData["idItem"]!
        let Deskripsi = itemData["Deskripsi"]!
        let BeratBarang = itemData["BeratBarang"]!
        let StatusPecah = itemData["StatusPecah"]!
        let StatusGaransi = itemData["StatusGaransi"]!
        
        let queryString = "UPDATE Item SET Deskripsi='\(Deskripsi)', BeratBarang='\(BeratBarang)', StatusPecah='\(StatusPecah)', StatusGaransi='\(StatusGaransi)' WHERE idItem='\(idItem)'"
        print("QUERY UPDATE Item: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing update: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    func dodeleteitem(itemData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let idItem = itemData["idItem"]!
        
        let queryString = "DELETE FROM Item WHERE idItem='\(idItem)'"
        print ("QUERY DELETE ITEM: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing delete item: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    
   
   
    
    
    // JENIS PENGIRIMAN
    func fetchJenisPengiriman() -> [[String: String]]? {
        let queryString = "SELECT * FROM JenisPengiriman"
        print ("QUERY FETCH JENIS PENGIRIMAN: \(queryString)")
        var stmt: OpaquePointer?
        var jenispengiriman: [[String: String]]?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: ReadValues: Error mempersiapkan jenis pengiriman: \(errmsg)")
            return nil
        }
        
        jenispengiriman = [[String: String]]()
        while (sqlite3_step(stmt)) == SQLITE_ROW {
            let idJenisPengiriman = sqlite3_column_int(stmt, 0)
            let NamaJenisPengiriman = String(cString: sqlite3_column_text(stmt, 1))
            let DeskripsiJenisPengiriman = String(cString: sqlite3_column_text(stmt, 2))
            let TarifJenisPengiriman = String(cString: sqlite3_column_text(stmt, 3))
            
            let tmp = [
                "idJenisPengiriman": String(idJenisPengiriman),
                "NamaJenisPengiriman": String(NamaJenisPengiriman),
                "DeskripsiJenisPengiriman": String(DeskripsiJenisPengiriman),
                "TarifJenisPengiriman": String(TarifJenisPengiriman)
            ]
            jenispengiriman?.append(tmp)
        }
        
        return jenispengiriman
    }
    func doInsertJenisPengiriman(param: [String: String]) -> Bool {
        var stmt: OpaquePointer?
        
        let NamaJenisPengiriman = param["NamaJenisPengiriman"]!
        let DeskripsiJenisPengiriman = param["DeskripsiJenisPengiriman"]!
        let TarifJenisPengiriman = param["TarifJenisPengiriman"]!
        
        let queryString = "INSERT INTO JenisPengiriman (NamaJenisPengiriman, DeskripsiJenisPengiriman, Tarif) VALUES ('\(NamaJenisPengiriman)','\(DeskripsiJenisPengiriman)','\(TarifJenisPengiriman)')"
        print("QUERY INSERT JenisPengiriman: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error saat melakukan insert: \(errmsg)")
            return false
        }
        
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    func doUpdateJenisPengiriman(param: [String: String]) -> Bool {
        var stmt: OpaquePointer?
        let idJenisPengiriman = param["idJenisPengiriman"]!
        let NamaJenisPengiriman = param["NamaJenisPengiriman"]!
        let DeskripsiJenisPengiriman = param["DeskripsiJenisPengiriman"]!
        let TarifJenisPengiriman = param["TarifJenisPengiriman"]!
        
        let queryString = "UPDATE JenisPengiriman SET NamaJenisPengiriman='\(NamaJenisPengiriman)', DeskripsiJenisPengiriman = '\(DeskripsiJenisPengiriman)', Tarif = '\(TarifJenisPengiriman)' WHERE idJenisPengiriman = '\(idJenisPengiriman)'"
        print("QUERY UPDATE JenisPengiriman : \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error saat melakukan update: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    
    func doDeleteJenisPengiriman(param: [String: String]) -> Bool {
        var stmt: OpaquePointer?
        let idJenisPengiriman = param["idJenisPengiriman"]!
        
        let queryString = "DELETE FROM JenisPengiriman WHERE idJenisPengiriman='\(idJenisPengiriman)'"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error saat melakukan delete: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    
    
    
    // KOTA
    func fetchkota() -> [[String: String]]? {
        let queryString = "SELECT * FROM Kota"
        print ("QUERY FETCH Kota: \(queryString)")
        var stmt: OpaquePointer?
        
        var Kota : [[String: String]]?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: ReadValues: Error preparing fetch kantor: \(errmsg)")
            return nil
        }
        Kota = [[String: String]]()
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let idKota = sqlite3_column_int(stmt, 0)
            let NamaKota = String(cString: sqlite3_column_text(stmt, 1))
            let RegionKota = String(cString: sqlite3_column_text(stmt, 2))
            
            let tmp = [
                "idKota" : String(idKota),
                "NamaKota" : NamaKota,
                "RegionKota" : RegionKota
            ]
            Kota?.append(tmp)
        }
        return Kota
    }
    func doInsertKota(kotaData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let NamaKota = kotaData["NamaKota"]!
        let RegionKota = kotaData["RegionKota"]!
        
        let queryString = "INSERT INTO Kota (NamaKota, RegionKota) VALUES ('\(NamaKota)','\(RegionKota)')"
        print ("QUERY INSERT Kota: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing insert kantor: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    func doUpdateKota(kotaData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let idKota = kotaData["idKota"]!
        let NamaKota = kotaData["NamaKota"]!
        let RegionKota = kotaData["RegionKota"]!
        
        let queryString = "UPDATE Kota SET NamaKota='\(NamaKota)', RegionKota='\(RegionKota)' WHERE idKota='\(idKota)'"
        print("QUERY UPDATE Kota: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing update: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    func dodeletekota(kotaData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let idKota = kotaData["idKota"]!
        
        let queryString = "DELETE FROM Kota WHERE idKota='\(idKota)'"
        print ("QUERY DELETE KOTA: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing insert Kota: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    
    
    
   
    
    
    // TRANSAKSI
    
    // ORDER
    // CREATE ORDER
    func doInsertOrder(orderData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let TanggalPemesanan = orderData["TanggalPemesanan"]!
        let NamaPelanggan = orderData["NamaPelanggan"]!
        let KotaPengirim = orderData["KotaPengirim"]!
        let NamaPenerima = orderData["NamaPenerima"]!
        let KotaPenerima = orderData["KotaPenerima"]!
        let DeskripsiBarang = orderData["DeskripsiBarang"]!
        let AlamatPenerima = orderData["AlamatPenerima"]!
        let JenisPengiriman = orderData["JenisPengiriman"]!
        
        let queryString = "INSERT INTO Pemesanan (TanggalPemesanan, NamaPelanggan, KotaPengirim, NamaPenerima, KotaPenerima, DeskripsiBarang, AlamatPenerima, JenisPengiriman) VALUES ('\(TanggalPemesanan)','\(NamaPelanggan)','\(KotaPengirim)','\(NamaPenerima)','\(KotaPenerima)','\(DeskripsiBarang)','\(AlamatPenerima)','\(JenisPengiriman)')"
        print ("QUERY INSERT Pemesanan: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing insert Pemesanan: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    // READ ORDER
    func fetchOrder() -> [[String: String]]? {
        let queryString = "SELECT * FROM Pemesanan"
        print ("QUERY FETCH Pemesanan: \(queryString)")
        var stmt: OpaquePointer?
        var Pemesanan: [[String: String]]?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: ReadValues: Error mempersiapkan Pemesanan: \(errmsg)")
            return nil
        }
        
        Pemesanan = [[String: String]]()
        while (sqlite3_step(stmt)) == SQLITE_ROW {
            let idOrder = sqlite3_column_int(stmt, 0)
            let TanggalPemesanan = String(cString: sqlite3_column_text(stmt, 1))
            let NamaPelanggan = String(cString: sqlite3_column_text(stmt, 2))
            let KotaPengirim = String(cString: sqlite3_column_text(stmt, 3))
            let NamaPenerima = String(cString: sqlite3_column_text(stmt, 4))
            let KotaPenerima = String(cString: sqlite3_column_text(stmt, 5))
            let DeskripsiBarang = String(cString: sqlite3_column_text(stmt, 6))
            let AlamatPenerima = String(cString: sqlite3_column_text(stmt, 7))
            let JenisPengiriman = String(cString: sqlite3_column_text(stmt, 8))
            
            let tmp = [
                "idOrder": String(idOrder),
                "TanggalPemesanan": TanggalPemesanan,
                "NamaPelanggan": NamaPelanggan,
                "KotaPengirim": KotaPengirim,
                "NamaPenerima": NamaPenerima,
                "KotaPenerima": KotaPenerima,
                "DeskripsiBarang": DeskripsiBarang,
                "AlamatPenerima": AlamatPenerima,
                "JenisPengiriman": JenisPengiriman
            ]
            Pemesanan?.append(tmp)
        }
        return Pemesanan
    }
    
    // PENGIRIMAN
    // CREATE PENGIRIMAN
    func doInsertPengiriman(PengirimanData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let NomorPemesanan = PengirimanData["NomorPemesanan"]!
        let TanggalPengiriman = PengirimanData["TanggalPengiriman"]!
        let TanggalPenerimaan = PengirimanData["TanggalPenerimaan"]!
        let JenisPengiriman = PengirimanData["JenisPengiriman"]!
        let NamaKurir = PengirimanData["NamaKurir"]!
        let NamaKantor = PengirimanData["NamaKantor"]!
        let StatusPengiriman = PengirimanData["StatusPengiriman"]!
        
        let queryString = "INSERT INTO Pengiriman (OrderID, TanggalPengiriman, TanggalPenerimaan, JenisPengiriman, NamaKurir, NamaKantor, StatusPengiriman) VALUES ('\(NomorPemesanan)','\(TanggalPengiriman)','\(TanggalPenerimaan)','\(JenisPengiriman)','\(NamaKurir)','\(NamaKantor)','\(StatusPengiriman)')"
        print ("QUERY INSERT Pemesanan: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing insert Pengiriman: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    // READ PENGIRIMAN
    func fetchpengiriman() -> [[String: String]]? {
        let queryString = "SELECT * FROM Pengiriman"
        print ("QUERY FETCH Pengiriman: \(queryString)")
        var stmt: OpaquePointer?
        
        var Pengiriman : [[String: String]]?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: ReadValues: Error preparing fetch Pengiriman: \(errmsg)")
            return nil
        }
        Pengiriman = [[String: String]]()
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let idPengiriman = sqlite3_column_int(stmt, 0)
            let OrderID = String(cString: sqlite3_column_text(stmt, 1))
            let TanggalPenerimaan = String(cString: sqlite3_column_text(stmt, 2))
            let TanggalPengiriman = String(cString: sqlite3_column_text(stmt, 3))
            let JenisPengiriman = String(cString: sqlite3_column_text(stmt, 4))
            let NamaKurir = String(cString: sqlite3_column_text(stmt, 5))
            let NamaKantor = String(cString: sqlite3_column_text(stmt, 6))
            let StatusPengiriman = String(cString: sqlite3_column_text(stmt, 7))
            
            
            let tmp = [
                "idPengiriman" : String(idPengiriman),
                "OrderID" : OrderID,
                "TanggalPenerimaan" : TanggalPenerimaan,
                "TanggalPengiriman" : TanggalPengiriman,
                "JenisPengiriman" : JenisPengiriman,
                "NamaKurir" : NamaKurir,
                "NamaKantor" : NamaKantor,
                "StatusPengiriman" : StatusPengiriman,
                ]
            Pengiriman?.append(tmp)
        }
        return Pengiriman
    }
    
    // PEMBAYARAN
    // CREATE PEMBAYARAN
    func doInsertPembayaran(pembayaranData: [String : String]) -> Bool {
        var stmt: OpaquePointer?
        
        let idOrder = pembayaranData["idOrder"]!
        let NamaPelanggan = pembayaranData["NamaPelanggan"]!
        let NamaJenisPengiriman = pembayaranData["NamaJenisPengiriman"]!
        let Deskripsi = pembayaranData["Deskripsi"]!
        
        let BeratBarang = pembayaranData["BeratBarang"]!
        let StatusPecah = pembayaranData["StatusPecah"]!
        let StatusGaransi = pembayaranData["StatusGaransi"]!
        let TarifJenisPengiriman = pembayaranData["TarifJenisPengiriman"]!
        
        let TotalPembayaran = pembayaranData["TotalPembayaran"]!
        
        let queryString = "INSERT INTO Pembayaran (idOrder, NamaPelanggan, NamaJenisPengiriman, Deskripsi, BeratBarang, StatusPecah, StatusGaransi, TarifJenisPengiriman, TotalPembayaran) VALUES ('\(idOrder)','\(NamaPelanggan)','\(NamaJenisPengiriman)','\(Deskripsi)','\(BeratBarang)','\(TarifJenisPengiriman)','\(StatusPecah)','\(StatusGaransi)','\(TotalPembayaran)')"
        print ("QUERY INSERT Pembayaran: \(queryString)")
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK
        {
            let errmsg = String (cString: sqlite3_errmsg(db)!)
            print("ERROR: SaveMethod: Error preparing insert Pembayaran: \(errmsg)")
            return false
        }
        return sqlite3_step(stmt) == SQLITE_DONE
    }
    func fetchpembayaran() -> [[String: String]]? {
        let queryString = "SELECT Pembayaran.idOrder, Pembayaran.NamaPelanggan, Pembayaran.NamaJenisPengiriman, Pembayaran.Deskripsi, Pembayaran.TotalPembayaran FROM Pembayaran"
        print ("QUERY FETCH Pembayaran: \(queryString)")
        var stmt: OpaquePointer?
        
        var Pembayaran : [[String: String]]?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("ERROR: ReadValues: Error preparing fetch Pembayaran: \(errmsg)")
            return nil
        }
        Pembayaran = [[String: String]]()
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let idOrder = String(cString: sqlite3_column_text(stmt, 0))
            let NamaPelanggan = String(cString: sqlite3_column_text(stmt, 1))
            let NamaJenisPengiriman = String(cString: sqlite3_column_text(stmt, 2))
            let Deskripsi = String(cString: sqlite3_column_text(stmt, 3))
            let TotalPembayaran = String(cString: sqlite3_column_text(stmt, 4))
            
            let tmp = [
                "idOrder": idOrder,
                "NamaPelanggan" : NamaPelanggan,
                "NamaJenisPengiriman" : NamaJenisPengiriman,
                "Deskripsi" : Deskripsi,
                "TotalPembayaran" : TotalPembayaran
                ]
            Pembayaran?.append(tmp)
        }
        return Pembayaran
    }
}

