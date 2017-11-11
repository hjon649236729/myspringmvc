package com.hjon.modules.workflow.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjon.common.service.BaseService;
import com.hjon.modules.workflow.entity.Agents;

@Service
@Transactional
public class AgentsService extends BaseService<Agents> {

}