<?php
namespace OCA\Health\Db;

use JsonSerializable;

use OCP\AppFramework\Db\Entity;

class Weightdata extends Entity implements JsonSerializable {

    protected $insertTime;
    protected $lastupdateTime;
    protected $personId;
    protected $bodyfat;
    protected $measurement;
    protected $weight;
    protected $date;

    public function __construct() {
        $this->addType('id','integer');
    }

    public function jsonSerialize() {
        return [
            'id' => $this->id,
            'insertTime' => $this->insertTime,
            'lastupdateTime' => $this->lastupdateTime,
            'personId' => $this->personId,
            'bodyfat' => $this->bodyfat,
            'measurement' => $this->measurement,
            'weight' => $this->weight,
            'date' => $this->date,
        ];
    }
}