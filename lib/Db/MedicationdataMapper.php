<?php
/**
 * @copyright Copyright (c) 2020 Florian Steffens <flost-dev@mailbox.org>
 *
 * @author Marcus Nitzschke <mail@kendix.org>
 *
 * @license GNU AGPL version 3 or any later version
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

namespace OCA\Health\Db;

use OCP\AppFramework\Db\QBMapper;
use OCP\IDBConnection;

class MedicationdataMapper extends QBMapper {

	public function __construct(IDBConnection $db) {
		parent::__construct($db, 'health_medicationdata', Medicationdata::class);
	}

	public function find(int $id) {
		$qb = $this->db->getQueryBuilder();

		$qb->select('*')
				 ->from($this->getTableName())
				 ->where(
				 	$qb->expr()->eq('id', $qb->createNamedParameter($id))
				 );

		return $this->findEntity($qb);
	}

	public function findAll(int $planId) {
		$qb = $this->db->getQueryBuilder();

		$qb->select('*')
		   ->from($this->getTableName())
		   ->where(
		   	$qb->expr()->eq('plan_id', $qb->createNamedParameter($planId))
		   );

		return $this->findEntities($qb);
	}

}
