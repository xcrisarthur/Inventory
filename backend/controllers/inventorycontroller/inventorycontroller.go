package inventorycontroller

import (
	"encoding/json"
	"net/http"

	"github.com/06202003/apiInventory/helper"
	"github.com/06202003/apiInventory/models"
	"github.com/gorilla/mux"
)

func Index(w http.ResponseWriter, r *http.Request) {
	var inventory []models.Inventory
	models.DB.Debug().Preload("Category").Find(&inventory)
	models.DB.Preload("Category").Find(&inventory)
	helper.ResponseJSON(w, http.StatusOK, map[string]interface{}{"inventory": inventory})
}

func Show(w http.ResponseWriter, r *http.Request) {
	var inventory models.Inventory
	id := mux.Vars(r)["kode_aset"]

	models.DB.Debug().Preload("Category").Find(&inventory, "kode_aset = ?", id)
	if err := models.DB.Preload("Category").Where("kode_aset = ?", id).First(&inventory).Error; err != nil {
		helper.ResponseJSON(w, http.StatusNotFound, map[string]string{"message": "Aset tidak ditemukan"})
		return
	}

	helper.ResponseJSON(w, http.StatusOK, map[string]interface{}{"inventory": inventory})
}

// func Create(w http.ResponseWriter, r *http.Request) {
// 	var inventory models.Inventory

// 	if err := json.NewDecoder(r.Body).Decode(&inventory); err != nil {
// 		helper.ResponseJSON(w, http.StatusBadRequest, map[string]string{"message": err.Error()})
// 		return
// 	}

// 	// Create a new inventory record
// 	models.DB.Create(&inventory)

// 	// Create a new history pemakaian record
// 	createHistoryPemakaian(inventory, "", inventory.EmployeeID, "", inventory.RoomID)

// 	helper.ResponseJSON(w, http.StatusOK, map[string]interface{}{"message": "Data Berhasil Dibuat"})
// }

func Create(w http.ResponseWriter, r *http.Request) {
  var inventories []models.Inventory

  if err := json.NewDecoder(r.Body).Decode(&inventories); err != nil {
    helper.ResponseJSON(w, http.StatusBadRequest, map[string]string{"message": err.Error()})
    return
  }

  // Loop through each inventory item and perform necessary calculations
  for i := range inventories {
    depreciation := (inventories[i].Price - (inventories[i].Price / 4)) / inventories[i].UsefulLife
    inventories[i].Depreciation = depreciation
    inventories[i].Year1 = inventories[i].Price - depreciation
    inventories[i].Year2 = inventories[i].Year1 - depreciation
    inventories[i].Year3 = inventories[i].Year2 - depreciation
    inventories[i].Year4 = inventories[i].Year3 - depreciation

    // Create a new inventory record
    models.DB.Create(&inventories[i])
  }

  helper.ResponseJSON(w, http.StatusCreated, map[string]interface{}{"message": "Aset Berhasil Dibuat"})
}


func Update(w http.ResponseWriter, r *http.Request) {
	var inventory models.Inventory
	id := mux.Vars(r)["kode_aset"]

	if err := json.NewDecoder(r.Body).Decode(&inventory); err != nil {
		helper.ResponseJSON(w, http.StatusBadRequest, map[string]string{"message": err.Error()})
		return
	}

	// Update the inventory record
	if models.DB.Model(&models.Inventory{}).Where("kode_aset = ?", id).Updates(&inventory).RowsAffected == 0 {
		helper.ResponseJSON(w, http.StatusBadRequest, map[string]string{"message": "Tidak dapat memperbarui Aset"})
		return
	}

	helper.ResponseJSON(w, http.StatusAccepted, map[string]interface{}{"message": "Data Berhasil Diperbaharui"})
}

func Delete(w http.ResponseWriter, r *http.Request) {
	var inventory models.Inventory
	id := mux.Vars(r)["kode_aset"]

	if err := models.DB.First(&inventory, "kode_aset = ?", id).Error; err != nil {
		helper.ResponseJSON(w, http.StatusNotFound, map[string]string{"message": "Aset tidak ditemukan"})
		return
	}

	if err := models.DB.Delete(&inventory).Error; err != nil {
		helper.ResponseJSON(w, http.StatusInternalServerError, map[string]string{"message": "Gagal menghapus Aset"})
		return
	}

	helper.ResponseJSON(w, http.StatusNoContent, map[string]interface{}{"message": "Data berhasil dihapus"})
}
