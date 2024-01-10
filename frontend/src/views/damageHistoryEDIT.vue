<template>
  <h1>Edit Damage History</h1>
  <div class="container">
    <form @submit.prevent="updateDamage">
      <div class="row row-cols-2 row-cols-lg-3 g-lg-3">
        <div class="mb-3 col">
          <label for="id" class="form-label">ID</label>
          <input v-model="damageItem.id" type="text" class="form-control" id="id" disabled>
        </div>
        <div class="mb-3 col">
          <label for="id_pemakaian" class="form-label">Id Pemakaian</label>
          <input v-model="damageItem.id_pemakaian" type="text" class="form-control" id="id_pemakaian" disabled>
        </div>
        <div class="mb-3 col">
          <label for="tanggal_kerusakan" class="form-label">Tanggal Kerusakan</label>
          <input v-model="damageItem.tanggal_kerusakan" type="datetime-local" class="form-control" id="tanggal_kerusakan" required>
        </div>
      </div>

      <button type="submit" class="btn btn-primary">Update Damage History</button>
    </form>
  </div>
</template>
  
<script>
import axios from 'axios';
import router from '../router';

export default {
  data() {
    return {
      damageItem: {
        id: '',
        id_pemakaian: '',
        tanggal_kerusakan: '',
      },
    };
  },
  created() {
        this.fetchDamageItem();
    },
  methods: {
    fetchDamageItem() {
      const itemId = this.$route.params.id;
      axios.get(`http://localhost:8080/api/problemHistories/${itemId}`)
        .then(response => {
          this.damageItem = response.data.Kerusakan;
        })
        .catch(error => {
          console.error('Error fetching damage history item:', error);
        });
    },
    updateDamage() {
      axios.put(`http://localhost:8080/api/problemHistories/${this.damageItem.id}`, this.damageItem)
        .then(() => {
          alert('categories item updated successfully');
          router.push({ path: `/damageHistory` });

        })
        .catch(error => {
          console.error('Error updating damage history item:', error);
        });
    },
  },
};
</script>
  
<style></style>