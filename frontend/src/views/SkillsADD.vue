<template>
    <div>
        <h1>Skills Add Data</h1>

        <div class="container">
            <form @submit.prevent="createSkills">
                <div class="row row-cols-2 row-cols-lg-3 g-lg-3">
                    <div class="col">
                        <div class="">
                            <label for="id_skill" class="form-label">ID SKILL</label>
                            <input v-model="newSkill.id_skill" type="text" class="form-control" id="id_skill" required>
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="nama" class="form-label">NAMA</label>
                            <input v-model="newSkill.nama" type="text" class="form-control" id="nama" required>
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="level" class="form-label">LEVEL</label>
                            <input v-model="newSkill.level" type="text" class="form-control" id="level" required>
                        </div>
                    </div>

                    <div class="col">
                        <div class="">
                            <label for="notes" class="form-label">NOTES</label>
                            <input v-model="newSkill.notes" type="text" class="form-control" id="notes" required>
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
import router from '../router';

export default {
    data() {
        return {
            newSkill: {
                // id_skill: '',
                nama: '',
                level: '',
                notes: '',
            },
            skills: [],
        };
    },
    mounted() {
        this.fetchSkills();
    },
    methods: {
        createSkills() {
            axios.post('http://localhost:8080/api/skills', this.newSkill)
                // eslint-disable-next-line no-unused-vars
                .then(response => {
                    this.newSkill = {};
                    router.push({ path: `/Skills` });
                })
                .catch(error => {
                    console.error('Error creating inventory:', error);
                });
        },
        fetchSkills() {
            axios.get('http://localhost:8080/api/skills')
                .then(response => {
                    this.skills = response.data.skills;
                })
                .catch(error => {
                    console.error('Error fetching location:', error);
                });
        },
    },
};
</script>

<style></style>