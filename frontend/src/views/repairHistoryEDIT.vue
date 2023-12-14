<template>
  <h1>Edit Repair History</h1>

  <div class="container">
    <form @submit.prevent="updateRepair">
      <div class="row row-cols-2 row-cols-lg-3 g-lg-3">

        <div class="mb-3 col">
          <label for="id_perbaikan" class="form-label">id_perbaikan</label>
          <input v-model="repairItem.id_perbaikan" type="text" class="form-control" id="id_perbaikan" required>
        </div>
        <div class="mb-3 col">
          <label for="tanggal_perbaikan" class="form-label">tanggal_perbaikan</label>
          <input v-model="repairItem.tanggal_perbaikan" type="datetime-local" class="form-control" id="tanggal_perbaikan"
            required>
        </div>
        <div class="mb-3 col">
          <label for="biaya" class="form-label">biaya</label>
          <input v-model="repairItem.biaya" type="text" class="form-control" id="biaya" required>
        </div>

        <div class="mb-3 col">
          <label for="deskripsi" class="form-label">deskripsi</label>
          <input v-model="repairItem.deskripsi" type="text" class="form-control" id="deskripsi" required>
        </div>
        <div class="mb-3 col">
          <label for="tanggal_kerusakan" class="form-label">tanggal_kerusakan</label>
          <input v-model="repairItem.tanggal_kerusakan" type="text" class="form-control" id="tanggal_kerusakan" required>
        </div>
        <div class="mb-3 col">
          <label for="tanggal_selesai_perbaikan" class="form-label">tanggal_selesai_perbaikan</label>
          <input v-model="repairItem.tanggal_selesai_perbaikan" type="text" class="form-control"
            id="tanggal_selesai_perbaikan" required>
        </div>
        <div class="mb-3 col">
          <label for="tempat_perbaikan" class="form-label">tempat_perbaikan</label>
          <input v-model="repairItem.tempat_perbaikan" type="text" class="form-control" id="tempat_perbaikan" required>
        </div>
        <div class="mb-3 col">
          <label for="id" class="form-label">id</label>
          <input v-model="repairItem.id" type="text" class="form-control" id="id" required>
        </div>
      </div>

      <button type="submit" class="btn btn-primary">Update Repair History</button>
    </form>
  </div>
</template>
  
<script>
import axios from 'axios';

export default {
  data() {
    return {
      repairItem: {
        id_perbaikan: '',
        tanggal_perbaikan: '',
        biaya: '',
        deskripsi: '',
        tanggal_kerusakan: '',
        tanggal_selesai_perbaikan: '',
        tempat_perbaikan: '',
        id: '',
      },
    };
  },
  created() {
        this.fetchRepairItem();
    },
  methods: {
    fetchRepairItem() {
      const itemId = this.$route.params.id;
      axios.get(`http://localhost:8080/api/repairHistories/${itemId}`)
        .then(response => {
          this.repairItem = response.data.Perbaikan;
        })
        .catch(error => {
          console.error('Error fetching damage history item:', error);
        });
    },
    updateRepair() {
      axios.put(`http://localhost:8080/api/repairHistories/${this.repairItem.id_perbaikan}`, this.repairItem)
        .then(() => {
          alert('categories item updated successfully');
        })
        .catch(error => {
          console.error('Error updating damage history item:', error);
        });
    },
  },
};
</script>
  
<style></style>