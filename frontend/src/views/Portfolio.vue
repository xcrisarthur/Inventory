<template>
  <div>
    <h1>Skill List</h1>
    <div class="d-flex flex-row mb-3">
      <div class="p-2 me-5">
        <button type="button" class="btn btn-success text-dark" @click="redirectToAddPage">Add Data</button>
      </div>
    </div>
    <table class="table table-striped text-center">
      <thead>
        <tr>
          <th class="text-uppercase">Id skill</th>
          <th class="text-uppercase">Nama</th>
          <th class="text-uppercase">Level</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="skill in filteredSkillsCsv" :key="skill.id_skill">
          <td>{{ skill.id_skill }}</td>
          <td>{{ skill.nama }}</td>
          <td>{{ skill.level }}</td>
          <!-- <td>
            <button type="button" class="btn btn-warning" @click="redirectToEditPage(skill.id_skill)">Edit</button>
            <button type="button" class="btn btn-danger ms-2" @click="deleteItem(skill.id_skill)">Delete</button>
          </td> -->
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';
import router from '../router';
import 'jspdf-autotable';

export default {
  data() {
    return {
      skillsCsv: [],
      selectedSkills: {},
      fileSelected: false,
      modalBackgroundColor: 'rgba(0, 0, 0, 0.50)',
    };
  },
  computed: {
    skills() {
      return this.$store.state.skills;
    },
    filteredSkills() {
      return this.skills.filter(
        (skills) => this.searchSkill(skills, this.searchText.toLowerCase()) && (this.selectedName === 'Nama' || skills.nama === this.selectedName) && (this.selectedLocation === 'Lokasi' || skills.Location?.nama === this.selectedLocation)
      );
    },
    filteredSkillsCsv() {
      return this.skillsCsv.filter((skills) => this.searchSkill(skills, this.searchText.toLowerCase()));
    },
  },
  mounted() {
    this.$store.dispatch('fetchData', {
      endpoint: 'skills',
      dataKey: 'skills',
      mutation: 'setSkillsList',
    });
  },
  methods: {
    deleteItem(itemId) {
      if (confirm('Are you sure you want to delete this item?')) {
        axios
          .delete(`http://localhost:8080/api/skills/${itemId}`)
          .then(() => {
            alert('Item successfully deleted.');
            window.location.reload();
          })
          .catch((error) => {
            console.error('Error deleting item:', error);
            alert('Failed to delete item.');
          });
      }
    },
    redirectToAddPage() {
      window.location.href = 'http://localhost:8081/SkillADD';
    },
    redirectToEditPage(itemId) {
      router.push({ path: `/skill/${itemId}` });
    },
  },
};
</script>
