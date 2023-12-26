<template>
    <div>
        <h1>Edit Room Item</h1>
        <div class="container">
            <form @submit.prevent="updateRoom">
                <div class="row row-cols-2 row-cols-lg-3 g-lg-3">
                    <div class="col form-group">
                        <label for="id_ruangan">ID RUANGAN</label>
                        <input v-model="roomItem.id_ruangan" type="text" class="form-control" id="id_ruangan" disabled>
                    </div>

                    <div class="col form-group">
                        <label for="nama">Nama</label>
                        <input v-model="roomItem.nama" type="text" class="form-control" id="nama" required>
                    </div>

                    <!-- <div class="col form-group">
                        <label for="id_lokasi" class="form-label">lokasi</label>
                        <input v-model="roomItem.id_lokasi" type="text" class="form-control" id="id_lokasi">
                    </div> -->

                    <div class="col form-group">
                        <label for="id_lokasi" class="form-label">lokasi</label>
                        <select v-model="roomItem.id_lokasi" class="form-select" id="id_lokasi">
                            <option v-for="location in locations" :value="location.id_lokasi" :key="location.id_lokasi">
                                {{ location.nama }}
                            </option>
                        </select>
                    </div>

                    <div class="col form-group">
                        <button type="submit" class="btn btn-primary">Update Data</button>
                    </div>

                </div>
            </form>
        </div>
    </div>
</template>
    
<script>
import axios from 'axios';
import router from '../router';

export default {
    data() {
        return {
            roomItem: {
                id_ruangan: '',
                nama: '',
                id_lokasi: '',
            },
            locations: [],
        };
    },
    created() {
        this.fetchRoomItem();
        this.fetchLocations();
    },
    methods: {
        fetchRoomItem() {
            const itemId = this.$route.params.id;
            axios.get(`http://localhost:8080/api/rooms/${itemId}`)
                .then(response => {
                    this.roomItem = response.data.room;
                })
                .catch(error => {
                    console.error('Error fetching rooms item:', error);
                });
        },
        updateRoom() {
            axios.put(`http://localhost:8080/api/rooms/${this.roomItem.id_ruangan}`, [this.roomItem])
                .then(() => {
                    alert('Inventory item updated successfully');
                    router.push({ path: `/Room` });

                })
                .catch(error => {
                    console.error('Error updating inventory item:', error);
                });
        },
        fetchLocations() {
            axios.get('http://localhost:8080/api/locations')
                .then(response => {
                    this.locations = response.data.locations;
                })
                .catch(error => {
                    console.error('Error fetching locations:', error);
                });
        },
    },
};
</script>
    
<style></style>
    