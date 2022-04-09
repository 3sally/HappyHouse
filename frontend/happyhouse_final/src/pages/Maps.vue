<template>
	<div class="content">
		<house-map-search-bar />
		<happy-house-map />
	</div>
</template>
<script>
import { Card } from "@/components/index";

import HouseMapSearchBar from "@/components/HouseMap/HouseMapSearchBar.vue";
import HappyHouseMap from "@/components/HouseMap/HappyHouseMap.vue";

export default {
	components: {
		Card,
		HouseMapSearchBar,
		HappyHouseMap,
	},
};
</script>
<style>
div,
h1,
h2,
h3,
h4,
h5,
h6 {
	color: black;
}
</style>
