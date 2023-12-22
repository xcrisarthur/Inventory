<template>
    <div>
        <h1>Room Add DATA</h1>

        <div class="container">
            <form @submit.prevent="createRoom">
                <div class="row row-cols-2 row-cols-lg-3 g-lg-3">
                    <div class="col">
                        <div class="">
                            <label for="id_ruangan" class="form-label">ID RUANGAN</label>
                            <input v-model="newRoom.id_ruangan" type="text" class="form-control" id="id_ruangan" required>
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="nama" class="form-label">NAMA</label>
                            <input v-model="newRoom.nama" type="text" class="form-control" id="nama" required>
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="id_lokasi" class="form-label">LOKASI</label>
                            <select v-model="newRoom.id_lokasi" class="form-select" id="id_lokasi">
                                <option v-for="location in locations" :value="location.id_lokasi" :key="location.id_lokasi">
                                    {{ location.nama }}
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="col">
                        <button type="submit" class="btn btn-primary">Add Data</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>


<script>
import axios from 'axios';

export default {
    data() {
        return {
            newRoom: {
                id_ruangan: '',
                nama: '',
                id_lokasi: '',
            },
            locations: [],
            rooms: [],
        };
    },
    mounted() {
        this.fetchLocations();
        this.fetchRooms();
    },
    methods: {
        createRoom() {
            axios.post('http://localhost:8080/api/rooms', [this.newRoom])
                // eslint-disable-next-line no-unused-vars
                .then(response => {
                    this.newRoom = {};
                })
                .catch(error => {
                    console.error('Error creating inventory:', error);
                });
        },
        fetchLocations() {
            axios.get('http://localhost:8080/api/locations')
                .then(response => {
                    this.locations = response.data.locations;
                    // console.log(this.locations)
                })
                .catch(error => {
                    console.error('Error fetching location:', error);
                });
        },
        fetchRooms() {
            axios.get('http://localhost:8080/api/rooms')
                .then(response => {
                    this.rooms = response.data.rooms;
                })
                .catch(error => {
                    console.error('Error fetching location:', error);
                });
        },
    },
};
</script>

<style></style>