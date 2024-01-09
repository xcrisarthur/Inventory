<template>
  <h1>Add New Repair History</h1>

  <div class="container">
    <form @submit.prevent="createRepair">
      <div class="row row-cols-2 row-cols-lg-3 g-lg-3">

        <div class="mb-3 col">
          <label for="id_perbaikan" class="form-label">id_perbaikan</label>
          <input v-model="newRepair.id_perbaikan" type="text" class="form-control" id="id_perbaikan">
        </div>
        <div class="mb-3 col">
          <label for="tanggal_perbaikan" class="form-label">tanggal_perbaikan</label>
          <input v-model="newRepair.tanggal_perbaikan" type="datetime-local" class="form-control" id="tanggal_perbaikan"
            required>
        </div>
        <div class="mb-3 col">
          <label for="biaya" class="form-label">biaya</label>
          <input v-model="newRepair.biaya" type="text" class="form-control" id="biaya" required>
        </div>

        <div class="mb-3 col">
          <label for="deskripsi" class="form-label">deskripsi</label>
          <input v-model="newRepair.deskripsi" type="text" class="form-control" id="deskripsi" required>
        </div>
        <div class="mb-3 col">
          <label for="tanggal_kerusakan" class="form-label">tanggal_kerusakan</label>
          <input v-model="newRepair.tanggal_kerusakan" type="datetime-local" class="form-control" id="tanggal_kerusakan" required>
        </div>
        <div class="mb-3 col">
          <label for="tanggal_selesai_perbaikan" class="form-label">tanggal_selesai_perbaikan</label>
          <input v-model="newRepair.tanggal_selesai_perbaikan" type="datetime-local" class="form-control"
            id="tanggal_selesai_perbaikan" required>
        </div>
        <div class="mb-3 col">
          <label for="tempat_perbaikan" class="form-label">tempat_perbaikan</label>
          <input v-model="newRepair.tempat_perbaikan" type="text" class="form-control" id="tempat_perbaikan" required>
        </div>
        <div class="mb-3 col">
          <label for="id" class="form-label">id</label>
          <!-- <input v-model="newRepair.id" type="text" class="form-control" id="id" required> -->

          <select v-model="newRepair.id" class="form-select" aria-label="Default select example">
            <option v-for="damageHistory in DamageHistoryList" :key="damageHistory.id" :value="damageHistory.id">{{ damageHistory.Usage.Inventory.nama }}</option>
          </select>
        </div>
      </div>

      <button type="submit" class="btn btn-primary">Add Data</button>
    </form>
  </div>
</template>
  
<script>
import axios from 'axios';
import router from '../router';

export default {
  data() {
    return {
      newRepair: {
        id_perbaikan: '',
        tanggal_perbaikan: '2023-12-26T03:26',
        biaya: '1000',
        deskripsi: 'hai',
        tanggal_kerusakan: '2023-12-20T03:26',
        tanggal_selesai_perbaikan: '2023-12-29T03:26',
        tempat_perbaikan: 'bec',
        id: '',
      },
    };
  },
  computed: {
    DamageHistoryList() {
      console.log(this.$store.state.DamageHistoryList)
      return this.$store.state.DamageHistoryList;
    },
  },
  mounted() {
    this.$store.dispatch('fetchData', {
      endpoint: 'problemHistories',
      dataKey: 'Kerusakan',
      mutation: 'setDamageHistoryList',
    });
  },
  methods: {
    createRepair() {
  // Convert id_perbaikan to a number
  this.newRepair.id_perbaikan = parseInt(this.newRepair.id_perbaikan);
  this.newRepair.biaya = parseInt(this.newRepair.biaya);
console.log(this.newRepair)
  axios.post('http://localhost:8080/api/repairHistories', this.newRepair)
    // eslint-disable-next-line no-unused-vars
    .then(response => {
      this.newRepair = {}; // Clear the form
      // console.log(response)
      router.push({ path: `/damageHistory` });

    })
    .catch(error => {
      console.error('Error creating category:', error);
    });
},
  },
};
</script>
  
<style></style>