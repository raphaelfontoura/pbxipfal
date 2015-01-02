<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

include('PHPExcel.php');
include('PHPExcel/IOFactory.php');

class gera_excel extends MY_Controller {
    
    function __construct() {
        parent::__construct();
        
    }
	
    public function index()
    {
            $notas = $this->session->userdata('export');
            $data_atual = date("dmyHis"); 
            $path = base_url()."downloads/relatoriopsa_".$data_atual.".xls";
            
            $fileType = 'Excel5';
            $fileName = "downloads/relatoriopsa_".$data_atual.".xls";
            
            $objPHPExcel = new PHPExcel();
            $objPHPExcel->setActiveSheetIndex(0)
                        ->setCellValue('A1', 'ID DA CHAMADA' )
                        ->setCellValue('B1', "DATA DA CHAMADA" )
                        ->setCellValue("C1", "COD. DO AGENTE" )
                        ->setCellValue("D1", "RAMAL" )
                        ->setCellValue("E1", "NOTA DO RAMAL" )
                        ->setCellValue("F1", "SERVICO" )
                        ->setCellValue("G1", "NOTA DO SERVICO" );
            $cont = 2;
             foreach ($notas as $row) { 
                $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(0, $cont, $row->id_chamada);
                $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(1, $cont, strftime("%d/%m/%Y %H:%M", strtotime($row->calldate)));
                $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(2, $cont, $row->agent_code);
                $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(3, $cont, $row->ramal);
                $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(4, $cont, $row->nota1);
                $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(5, $cont, $row->servico);
                $objPHPExcel->getActiveSheet()->setCellValueByColumnAndRow(6, $cont, $row->nota2);
                $cont++;
            }
            $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setAutoSize(true);
            $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
            $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setAutoSize(true);
            $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setAutoSize(true);
            $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setAutoSize(true);
            $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setAutoSize(true);
            $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setAutoSize(true);
            
            $objPHPExcel->getActiveSheet()->setTitle('Relatorio PSA');
            $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
            $objWriter->save($fileName);
            $nome_arq = "relatoriopsa_".$data_atual;
            $this->session->unset_userdata('export');
            
            header('Content-type: application/vnd.ms-excel');
            header('Content-Disposition: attachment; filename="'.$nome_arq.'.xls"');
            readfile('downloads/'.$nome_arq.'.xls');

    }

    
}
