document.addEventListener("DOMContentLoaded", function () {
    fetch('AssetServlet') // Gọi servlet để lấy dữ liệu
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById('assetChart').getContext('2d');
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: data.labels,
                    datasets: [{
                        data: data.values,
                        backgroundColor: ['blue', 'cyan', 'purple', 'yellow'],
                        hoverOffset: 10
                    }]
                },
                options: {
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function (tooltipItem) {
                                    return `${tooltipItem.label}: ${tooltipItem.raw}%`;
                                }
                            }
                        }
                    }
                }
            });
        });
});
