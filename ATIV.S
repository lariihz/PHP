<?php
function fetchPage($url) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $output = curl_exec($ch);
    curl_close($ch);
    return $output;
}

class HeavyTask extends Thread {
    public function run() {
        $sum = 0;
        for ($i = 0; $i < 1000000; $i++) {
            $sum += sqrt($i); // Simulação de cálculo pesado
        }
        echo "Cálculo pesado concluído: $sum\n";
    }
}

function listFilesInBackground($directory) {
    $command = "ls -la " . escapeshellarg($directory) . " > output.txt &"; // Execução em background
    exec($command);
}

$heavyTask = new HeavyTask();
$heavyTask->start();

$pageContent = fetchPage("https://www.example.com");
echo "Página carregada com sucesso!\n";

listFilesInBackground(__DIR__);

$heavyTask->join(); // Esperando a thread terminar
echo "Todas as tarefas foram concluídas!\n";
?>
