<template>
  <table class="table tablesorter table-hover" :class="tableClass">
    <thead :class="theadClasses">
      <tr>
        <slot name="columns">
          <th v-for="column in columns" :key="column">{{ column }}</th>
        </slot>
      </tr>
    </thead>
    <tbody :class="tbodyClasses">
      <tr
        hover
        v-for="(item, index) in data"
        :key="index"
        @click="detail(item)"
      >
        <slot :row="item">
          <td
            v-for="(column, index) in columns"
            :key="index"
            v-if="hasValue(item, column)"
          >
            {{ itemValue(item, column) }}
          </td>
        </slot>
      </tr>
    </tbody>
  </table>
</template>
<script>
export default {
  name: "base-table",
  props: {
    tableClass: {
      type: String,
      default: "",
    },
    theadClasses: {
      type: String,
      default: "",
    },
    tbodyClasses: {
      type: String,
      default: "",
    },
    data: {
      type: Array,
      default: () => [],
    },
    columns: {
      type: Array,
      default: () => [],
    },
  },
  methods: {
    hasValue(item, column) {
      return item[column] !== "undefined";
    },
    itemValue(item, column) {
      return item[column];
    },
    detail(item) {
      console.log("click !!! =>", item);
    },
  },
};
</script>
<style></style>
